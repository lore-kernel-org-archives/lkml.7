Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABE4C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 12:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD4312171F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 12:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564661543;
	bh=oIaRqmpy4nbMnyVSHQ2jwoHghsxRXBYnSkrs4LmjELU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=osXP2WZtPgjB+JrckMdcXORXfaprM3SwjmsXxrByFPBKA8NnOyq8zGI6eTVbFP+QW
	 JDHUoxB+ctwOxAP9opB/cs9prrR/M+6H95bf5k/mIYZIht/pJ5BZXA6Ijs0N25HGzS
	 Od+/n6F1SrZ7+UL5uKnf/M3Z26b5BVgxujuRulIw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbfHAMMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 08:12:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:57316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728592AbfHAMMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 08:12:22 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52C70214DA;
        Thu,  1 Aug 2019 12:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564661541;
        bh=oIaRqmpy4nbMnyVSHQ2jwoHghsxRXBYnSkrs4LmjELU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XpjBoZOM9WEMmJnVixUe8KlMMnHzHLMwsEfaOe5HpMAunBpn20UoOMHV/gjCXcw14
         e6uSzA0A769JajDOkm2zd4fd5l3J8MfUlCD0Peh/QIJRPoVq4LzNVUBu+1ItDmblca
         aS2iudqWh/M9bSjEGPHLN0UITfRFIXT9oMYdGsgQ=
Date:   Thu, 1 Aug 2019 13:12:17 +0100
From:   Will Deacon <will@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Catalin Marinas <catalin.marinas@arm.com>, andreyknvl@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: fix variable 'tag' set but not used
Message-ID: <20190801121216.gsvneelth6scj57s@willie-the-truck>
References: <1564605498-17629-1-git-send-email-cai@lca.pw>
 <20190801120121.6cmtho3wd32nzfoz@willie-the-truck>
 <5E9F5456-3B82-4CB8-868B-1C7B4CBE4CBC@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5E9F5456-3B82-4CB8-868B-1C7B4CBE4CBC@lca.pw>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 08:07:12AM -0400, Qian Cai wrote:
> 
> 
> > On Aug 1, 2019, at 8:01 AM, Will Deacon <will@kernel.org> wrote:
> > 
> > On Wed, Jul 31, 2019 at 04:38:18PM -0400, Qian Cai wrote:
> >> When CONFIG_KASAN_SW_TAGS=n, set_tag() is compiled away. GCC throws a
> >> warning,
> >> 
> >> mm/kasan/common.c: In function '__kasan_kmalloc':
> >> mm/kasan/common.c:464:5: warning: variable 'tag' set but not used
> >> [-Wunused-but-set-variable]
> >>  u8 tag = 0xff;
> >>     ^~~
> >> 
> >> Fix it by making __tag_set() a static inline function.
> >> 
> >> Signed-off-by: Qian Cai <cai@lca.pw>
> >> ---
> >> arch/arm64/include/asm/memory.h | 6 +++++-
> >> 1 file changed, 5 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> >> index b7ba75809751..9645b1340afe 100644
> >> --- a/arch/arm64/include/asm/memory.h
> >> +++ b/arch/arm64/include/asm/memory.h
> >> @@ -210,7 +210,11 @@ static inline unsigned long kaslr_offset(void)
> >> #define __tag_reset(addr)	untagged_addr(addr)
> >> #define __tag_get(addr)		(__u8)((u64)(addr) >> 56)
> >> #else
> >> -#define __tag_set(addr, tag)	(addr)
> >> +static inline const void *__tag_set(const void *addr, u8 tag)
> >> +{
> >> +	return addr;
> >> +}
> > 
> > Why doesn't this trigger a warning in page_to_virt(), which passes an
> > unsigned long for the address parameter?
> 
> #define page_to_virt(page) … __tag_set(__addr, page_kasan_tag(page)); …
> 
> static inline u8 page_kasan_tag(const struct page *page)
> {	
> 	return 0xff;
> }
> 
> GCC will see that “page” is used.

No, I mean because you're making addr 'const void *'.

/me finds a toolchain.

Look:


In file included from ./arch/arm64/include/asm/pgtable-hwdef.h:8,
                 from ./arch/arm64/include/asm/processor.h:35,
                 from ./include/linux/mutex.h:19,
                 from ./include/linux/kernfs.h:12,
                 from ./include/linux/sysfs.h:16,
                 from ./include/linux/kobject.h:20,
                 from ./include/linux/of.h:17,
                 from ./include/linux/irqdomain.h:35,
                 from ./include/linux/acpi.h:13,
                 from ./include/acpi/apei.h:9,
                 from ./include/acpi/ghes.h:5,
                 from ./include/linux/arm_sdei.h:14,
                 from arch/arm64/kernel/asm-offsets.c:10:
./include/linux/mm.h: In function ‘lowmem_page_address’:
./arch/arm64/include/asm/memory.h:309:14: warning: passing argument 1 of ‘__tag_set’ makes pointer from integer without a cast [-Wint-conversion]
    __tag_set(__addr, page_kasan_tag(page));  \
              ^~~~~~
./include/linux/mm.h:1302:9: note: in expansion of macro ‘page_to_virt’
  return page_to_virt(page);
         ^~~~~~~~~~~~
./arch/arm64/include/asm/memory.h:213:49: note: expected ‘const void *’ but argument is of type ‘long unsigned int’
 static inline const void *__tag_set(const void *addr, u8 tag)
                                     ~~~~~~~~~~~~^~~~
./arch/arm64/include/asm/memory.h:309:4: warning: initialization of ‘long unsigned int’ from ‘const void *’ makes integer from pointer without a cast [-Wint-conversion]
    __tag_set(__addr, page_kasan_tag(page));  \
    ^~~~~~~~~
./include/linux/mm.h:1302:9: note: in expansion of macro ‘page_to_virt’
  return page_to_virt(page);
         ^~~~~~~~~~~~


If you're going to send patches removing compiler warnings, please have the
courtesy to test them first.

Will
