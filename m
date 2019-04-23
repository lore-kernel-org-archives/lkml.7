Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C148C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEBF8218B0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfDWUfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 16:35:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49270 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfDWUfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 16:35:34 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1A02DC067C11;
        Tue, 23 Apr 2019 20:35:33 +0000 (UTC)
Received: from redhat.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8546060141;
        Tue, 23 Apr 2019 20:35:31 +0000 (UTC)
Date:   Tue, 23 Apr 2019 16:35:29 -0400
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Cc:     Jessica Yu <jeyu@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Joao Moreira <jmoreira@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michael Matz <matz@suse.de>, Miroslav Benes <mbenes@suse.cz>,
        Nicolai Stange <nstange@suse.de>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v3 3/9] livepatch: Add klp-convert tool
Message-ID: <20190423203529.GA15743@redhat.com>
References: <20190410155058.9437-1-joe.lawrence@redhat.com>
 <20190410155058.9437-4-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410155058.9437-4-joe.lawrence@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 23 Apr 2019 20:35:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 11:50:52AM -0400, Joe Lawrence wrote:
> 
> [ ... snip ... ]
> 
> +static bool convert_rela(struct section *oldsec, struct rela *r,
> +		struct sympos *sp, struct elf *klp_elf)
> +{
> +	struct section *sec;
> +	struct rela *r1, *r2;
> +
> +	sec = get_or_create_klp_rela_section(oldsec, sp, klp_elf);
> +	if (!sec) {
> +		WARN("Can't create or access klp.rela section (%s.%s)\n",
> +				sp->object_name, sp->symbol_name);
> +		return false;
> +	}
> +
> +	if (!convert_klp_symbol(r->sym, sp)) {
> +		WARN("Unable to convert symbol name (%s.%s)\n", sec->name,
> +				r->sym->name);
> +		return false;
> +	}
> +
> +	/* Move the converted rela to klp rela section */
> +	list_for_each_entry_safe(r1, r2, &oldsec->relas, list) {
> +		if (r1->sym->name == r->sym->name) {
> +			list_del(&r1->list);
> +			list_add(&r1->list, &sec->relas);
> +		}
> +	}
> +	return true;
> +}

This one took a while to find and debug, but I believe that
convert_rela()'s list removal is not as safe as it thinks it is.

Start with its calling context from main() below:

> +	list_for_each_entry_safe(sec, aux, &klp_elf->sections, list) {
> +		if (!is_rela_section(sec))
> +			continue;
> +
> +		list_for_each_entry_safe(rela, tmprela, &sec->relas, list) {
> +			if (!must_convert(rela->sym))
> +				continue;
> +
> +			if (!find_missing_position(rela->sym, &sp)) {
> +				WARN("Unable to find missing symbol: %s",
> +						rela->sym->name);
> +				return -1;
> +			}
> +			if (!convert_rela(sec, rela, &sp, klp_elf)) {
> +				WARN("Unable to convert relocation: %s",
> +						rela->sym->name);
> +				return -1;
> +			}
> +		}
> +	}

AFAIK the *_safe list traversals, they cache the ->next value at the
beginning of each iteration, so that one could blow the current element
in position away.  The cached ->next value is then assigned when moving
to the next iteration.

But notice how convert_rela() looks through the entire list of
relocations, moving each rela with a matching symbol?

Consider a slight tweak to samples/livepatch-annotated.c:


  static int livepatch_cmdline_proc_show(struct seq_file *m, void *v)
  {
+         if (saved_command_line)
+                 saved_command_line[0] = '\0';
+
          seq_printf(m, "%s livepatch=1\n", saved_command_line);
          return 0;
  }


On my system, this generates relocations like this:

  % eu-readelf --relocs samples/livepatch/livepatch-annotated-sample.o
  Relocation section [ 2] '.rela.text' for section [ 1] '.text' at offset 0x98 contains 9 entries:
    Offset              Type            Value               Addend Name
    0x0000000000000001  X86_64_PC32     000000000000000000      -4 __fentry__
    0x0000000000000008  X86_64_PC32     000000000000000000      -4 saved_command_line
    0x0000000000000017  X86_64_PC32     000000000000000000      -4 saved_command_line
    0x000000000000001e  X86_64_32S      000000000000000000      +0 .rodata.str1.1
    0x0000000000000023  X86_64_PC32     000000000000000000      -4 seq_printf
    0x0000000000000031  X86_64_PC32     000000000000000000      -4 __fentry__
    0x0000000000000038  X86_64_32S      000000000000000000      +0 .data
    0x0000000000000051  X86_64_PC32     000000000000000000      -4 __fentry__
    0x000000000000003d  X86_64_PC32     000000000000000000      -4 klp_enable_patch

We now have back-to-back rela's with sym->name = "saved_command_line".
When the first is converted, convert_rela() will move both of them to
the klp rela section.  The linked list values may be consistent, but the
cached ->next value will be bogus and the in-flight-traversal will run
off the rails.


I think we can work around it with a combination of 1) only moving a
single rela symbol at a time in convert_rela and 2) processing the
second (third, etc.) a little bit more so that they are moved
individually.

I hacked this together and it works against the livepatch-annotate.c
test above so far...

-->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8--

diff --git a/scripts/livepatch/klp-convert.c b/scripts/livepatch/klp-convert.c
index 82c27d219372..126395f1c0cd 100644
--- a/scripts/livepatch/klp-convert.c
+++ b/scripts/livepatch/klp-convert.c
@@ -517,6 +517,7 @@ static bool convert_rela(struct section *oldsec, struct rela *r,
 		if (r1->sym->name == r->sym->name) {
 			list_del(&r1->list);
 			list_add(&r1->list, &sec->relas);
+			break;
 		}
 	}
 	return true;
@@ -549,8 +550,8 @@ static bool is_converted(char *sname)
 }
 
 /*
- * Checks if symbol must be converted (conditions):
- * not resolved, not already converted or isn't an exported symbol
+ * Checks if symbol must be or was already converted (conditions):
+ * not resolved or isn't an exported symbol
  */
 static bool must_convert(struct symbol *sym)
 {
@@ -566,7 +567,7 @@ static bool must_convert(struct symbol *sym)
 	if (strcmp(sym->name, ".TOC.") == 0)
 		return false;
 
-	return (!(is_converted(sym->name) || is_exported(sym->name)));
+	return (!is_exported(sym->name));
 }
 
 /* Checks if a section is a klp rela section */
@@ -640,7 +641,8 @@ int main(int argc, const char **argv)
 			if (!must_convert(rela->sym))
 				continue;
 
-			if (!find_missing_position(rela->sym, &sp)) {
+			if (!is_converted(rela->sym->name) &&
+			    !find_missing_position(rela->sym, &sp)) {
 				WARN("Unable to find missing symbol: %s",
 						rela->sym->name);
 				return -1;
-- 
2.20.1

