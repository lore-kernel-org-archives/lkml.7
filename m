Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9945AC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579BB20856
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tn+78p6L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389420AbfHVUSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 16:18:08 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35668 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730203AbfHVUSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 16:18:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id k2so6600372wrq.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 13:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EoX0w2ffRAXD9iRMEYuBFrf71DW9tIqxp6HPb5Vjx4c=;
        b=Tn+78p6Lkt6tOLMsZP3sX+V9JD2BqmFKb5pSg9I97HB8ZzN6GLfVB5ZnWr6ieieLnA
         y+D7IpVsEEysM8Bmx4kTrdqdsDcgn322BHxJJaOiu31MyeQfwnGNreu3AWVBV5W2gbD+
         /uBgHITf39YweTNDS3bK/hoD+8Dctass4Wtwt12xR77xZ6soPWcSgWWGx5tlmBAmKx4G
         FGorHOTxG7K1FRY3zRwWkmjG9ubLsfJy0sX1lW+iex3OOX7IClMvt/cIt6IyYn0WYwF1
         kivSsY0aBdL3wv549PgsOVxL7GN8t3e6gIPQSQVkdY8LkKFdMCQhKzq7Xs2ol4iLHX9D
         z1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EoX0w2ffRAXD9iRMEYuBFrf71DW9tIqxp6HPb5Vjx4c=;
        b=bw7aKqBqgVUEr0KE+NMx2bTM0GOFRDnymzVm+Q/dX+YyHHmKs60MhelkKzToAgyD9N
         ALiYrBa2uZ8FUmUakuGbOnAK/9/oWh3Rv+ZjbUdgR19Zi2euuJ/p9tcMhyE9I07aBuGV
         dpneqV3TRir32BIU7IyRmmQImqhq1ugqcrDXywcpbvWSHNDU87Kgsrn5iR7WCc/CzSRF
         a50QXmm65LNbmuV4qFlhIEka8bTAtz4azh/RO3DEqDDVrz5SVu1Johkq4GVUn8wV9MgC
         BIsBwgaCKFbNCcHWpjp1RO0SzAv8xdpsf3POTx8Wy1Y/JbRIpGJ2/ul9g+86SvXxjHIL
         yBqw==
X-Gm-Message-State: APjAAAV9sHykS2wBZiWgIA3AVqvhTUGPk9cAArp7WRUAoNN0gX82hHJ1
        nL30R3cgR/Wwz9UobQTjEm4=
X-Google-Smtp-Source: APXvYqyXKo8VmDuIQ51daaEQlwnn3TeaPZJrgRVPqe+SaJeTxCjHWOuD93FJ2Fewoppspbyr7bRuLg==
X-Received: by 2002:a05:6000:152:: with SMTP id r18mr860648wrx.41.1566505084152;
        Thu, 22 Aug 2019 13:18:04 -0700 (PDT)
Received: from [192.168.1.67] (host81-157-241-155.range81-157.btcentralplus.com. [81.157.241.155])
        by smtp.gmail.com with ESMTPSA id r190sm1291974wmf.0.2019.08.22.13.18.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 13:18:03 -0700 (PDT)
Subject: Re: [RFC v4 05/18] objtool: special: Adapt special section handling
To:     Raphael Gault <raphael.gault@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com
Cc:     peterz@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com,
        raph.gault+kdev@gmail.com
References: <20190816122403.14994-1-raphael.gault@arm.com>
 <20190816122403.14994-6-raphael.gault@arm.com>
From:   Julien <julien.thierry.kdev@gmail.com>
Message-ID: <73b70bcd-1476-ebf7-f84e-d7b01b1e022e@gmail.com>
Date:   Thu, 22 Aug 2019 21:18:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20190816122403.14994-6-raphael.gault@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Raphaël,

On 16/08/19 13:23, Raphael Gault wrote:
> This patch abstracts the few architecture dependent tests that are
> perform when handling special section and switch tables. It enables any
> architecture to ignore a particular CPU feature or not to handle switch
> tables.

I think it would be better if this patch only focused on CPU features 
and leave dealing with switch table to subsequent patches.

> 
> Signed-off-by: Raphael Gault <raphael.gault@arm.com>
> ---
>   tools/objtool/arch/arm64/Build                |  1 +
>   tools/objtool/arch/arm64/arch_special.c       | 22 +++++++++++++++
>   .../objtool/arch/arm64/include/arch_special.h | 10 +++++--
>   tools/objtool/arch/x86/Build                  |  1 +
>   tools/objtool/arch/x86/arch_special.c         | 28 +++++++++++++++++++
>   tools/objtool/arch/x86/include/arch_special.h |  9 ++++++
>   tools/objtool/check.c                         | 24 ++++++++++++++--
>   tools/objtool/special.c                       |  9 ++----
>   tools/objtool/special.h                       |  3 ++
>   9 files changed, 96 insertions(+), 11 deletions(-)
>   create mode 100644 tools/objtool/arch/arm64/arch_special.c
>   create mode 100644 tools/objtool/arch/x86/arch_special.c
> 
> diff --git a/tools/objtool/arch/arm64/Build b/tools/objtool/arch/arm64/Build
> index bf7a32c2b9e9..3d09be745a84 100644
> --- a/tools/objtool/arch/arm64/Build
> +++ b/tools/objtool/arch/arm64/Build
> @@ -1,3 +1,4 @@
> +objtool-y += arch_special.o
>   objtool-y += decode.o
>   objtool-y += orc_dump.o
>   objtool-y += orc_gen.o
> diff --git a/tools/objtool/arch/arm64/arch_special.c b/tools/objtool/arch/arm64/arch_special.c
> new file mode 100644
> index 000000000000..a21d28876317
> --- /dev/null
> +++ b/tools/objtool/arch/arm64/arch_special.c
> @@ -0,0 +1,22 @@
> +/*
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +#include "../../special.h"
> +#include "arch_special.h"
> +
> +void arch_force_alt_path(unsigned short feature,
> +			 bool uaccess,
> +			 struct special_alt *alt)
> +{
> +}
> diff --git a/tools/objtool/arch/arm64/include/arch_special.h b/tools/objtool/arch/arm64/include/arch_special.h
> index 63da775d0581..185103be8a51 100644
> --- a/tools/objtool/arch/arm64/include/arch_special.h
> +++ b/tools/objtool/arch/arm64/include/arch_special.h
> @@ -30,7 +30,13 @@
>   #define ALT_ORIG_LEN_OFFSET	10
>   #define ALT_NEW_LEN_OFFSET	11
>   
> -#define X86_FEATURE_POPCNT (4 * 32 + 23)
> -#define X86_FEATURE_SMAP   (9 * 32 + 20)
> +static inline bool arch_should_ignore_feature(unsigned short feature)
> +{
> +	return false;
> +}
>   
> +static inline bool arch_support_switch_table(void)
> +{
> +	return false;

If I understand correctly , this gets later (patch 8) replaced by 
arch_find_switch_table() which can return NULL if unable to find a 
switch table.

So, is it necessary to introduce this function at this stage of the 
patchset? Can't we just have directly arch_find_switch_table() ?

Also, I believe that in the end you keep the two 
arch_support_switch_table() implementations (x86 and arm64) despite 
getting rid of the only caller (in patch 8).


> +}
>   #endif /* _ARM64_ARCH_SPECIAL_H */
> diff --git a/tools/objtool/arch/x86/Build b/tools/objtool/arch/x86/Build
> index 1f11b45999d0..63e167775bc8 100644
> --- a/tools/objtool/arch/x86/Build
> +++ b/tools/objtool/arch/x86/Build
> @@ -1,3 +1,4 @@
> +objtool-y += arch_special.o
>   objtool-y += decode.o
>   objtool-y += orc_dump.o
>   objtool-y += orc_gen.o
> diff --git a/tools/objtool/arch/x86/arch_special.c b/tools/objtool/arch/x86/arch_special.c
> new file mode 100644
> index 000000000000..6583a1770bb2
> --- /dev/null
> +++ b/tools/objtool/arch/x86/arch_special.c
> @@ -0,0 +1,28 @@
> +/*
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +#include "../../special.h"
> +#include "arch_special.h"
> +
> +void arch_force_alt_path(unsigned short feature,
> +			 bool uaccess,

Maybe you could have something like:

void arch_select_alt_path(unsigned short feature, struct special_alt *alt);

or arch_process_alt_inst(...);

This way you just let the arch decide what to do for alternative 
instructions associated with their features, and call it in the "if 
(entry->feature)" branch of get_alt_entry().

You don't need to pass the "uaccess" as that info is globally accessible 
from builtin.h.

> +			 struct special_alt *alt)
> +{
> +		if (feature == X86_FEATURE_SMAP) {
> +			if (uaccess)
> +				alt->skip_orig = true;
> +			else
> +				alt->skip_alt = true;
> +		}
> +}
> diff --git a/tools/objtool/arch/x86/include/arch_special.h b/tools/objtool/arch/x86/include/arch_special.h
> index 424ce47013e3..fce2b1193194 100644
> --- a/tools/objtool/arch/x86/include/arch_special.h
> +++ b/tools/objtool/arch/x86/include/arch_special.h
> @@ -33,4 +33,13 @@
>   #define X86_FEATURE_POPCNT (4 * 32 + 23)
>   #define X86_FEATURE_SMAP   (9 * 32 + 20)
>   
> +static inline bool arch_should_ignore_feature(unsigned short feature)
> +{
> +	return feature == X86_FEATURE_POPCNT;
> +}

With my above suggestion you shouldn't need that and just use the arch 
specific alternative handling set the alt->skip_orig.

> +
> +static inline bool arch_support_switch_table(void)
> +{
> +	return true;
> +}
>   #endif /* _X86_ARCH_SPECIAL_H */
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 30e147391dcb..4af6422d3428 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -729,7 +729,7 @@ static int handle_group_alt(struct objtool_file *file,
>   		last_orig_insn = insn;
>   	}
>   
> -	if (next_insn_same_sec(file, last_orig_insn)) {
> +	if (last_orig_insn && next_insn_same_sec(file, last_orig_insn)) {
>   		fake_jump = malloc(sizeof(*fake_jump));
>   		if (!fake_jump) {
>   			WARN("malloc failed");
> @@ -1061,6 +1061,26 @@ static struct rela *find_jump_table(struct objtool_file *file,
>   		table_rela = find_rela_by_dest(table_sec, table_offset);
>   		if (!table_rela)
>   			continue;
> +		/*
> +		 * If we are on arm64 architecture, we now that we
> +		 * are in presence of a switch table thanks to
> +		 * the `br <Xn>` insn. but we can't retrieve it yet.
> +		 * So we just ignore unreachable for this file.
> +		 */
> +		if (!arch_support_switch_table()) {
> +			file->ignore_unreachables = true;
> +			return NULL;
> +		}
> +
> +		rodata_rela = find_rela_by_dest(rodata_sec, table_offset);
> +		if (rodata_rela) {
> +			/*
> +			 * Use of RIP-relative switch jumps is quite rare, and
> +			 * indicates a rare GCC quirk/bug which can leave dead
> +			 * code behind.
> +			 */
> +			if (text_rela->type == R_X86_64_PC32)
> +				file->ignore_unreachables = true;
>   
>   		/*
>   		 * Use of RIP-relative switch jumps is quite rare, and
> @@ -1864,7 +1884,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
>   	insn = first;
>   	sec = insn->sec;
>   
> -	if (insn->alt_group && list_empty(&insn->alts)) {
> +	if (!insn->visited && insn->alt_group && list_empty(&insn->alts)) {
>   		WARN_FUNC("don't know how to handle branch to middle of alternative instruction group",
>   			  sec, insn->offset);
>   		return 1;
> diff --git a/tools/objtool/special.c b/tools/objtool/special.c
> index b8ccee1b5382..7a0092d6e5b3 100644
> --- a/tools/objtool/special.c
> +++ b/tools/objtool/special.c
> @@ -81,7 +81,7 @@ static int get_alt_entry(struct elf *elf, struct special_entry *entry,
>   		 * feature path which is a "very very small percentage of
>   		 * machines".
>   		 */
> -		if (feature == X86_FEATURE_POPCNT)
> +		if (arch_should_ignore_feature(feature))
>   			alt->skip_orig = true;
>   
>   		/*
> @@ -93,12 +93,7 @@ static int get_alt_entry(struct elf *elf, struct special_entry *entry,
>   		 * find paths that see the STAC but take the NOP instead of
>   		 * CLAC and the other way around.
>   		 */
> -		if (feature == X86_FEATURE_SMAP) {
> -			if (uaccess)
> -				alt->skip_orig = true;
> -			else
> -				alt->skip_alt = true;
> -		}
> +		arch_force_alt_path(feature, uaccess, alt);
>   	}
>   
>   	orig_rela = find_rela_by_dest(sec, offset + entry->orig);
> diff --git a/tools/objtool/special.h b/tools/objtool/special.h
> index 35061530e46e..90626a7e41cf 100644
> --- a/tools/objtool/special.h
> +++ b/tools/objtool/special.h
> @@ -27,5 +27,8 @@ struct special_alt {
>   };
>   
>   int special_get_alts(struct elf *elf, struct list_head *alts);
> +void arch_force_alt_path(unsigned short feature,
> +			 bool uaccess,
> +			 struct special_alt *alt);
>   
>   #endif /* _SPECIAL_H */
> 

CHeers,

-- 
Julien Thierry
