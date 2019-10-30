Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFD7CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F35D20717
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfJ3S3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 14:29:52 -0400
Received: from david.siemens.de ([192.35.17.14]:55175 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726795AbfJ3S3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 14:29:51 -0400
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by david.siemens.de (8.15.2/8.15.2) with ESMTPS id x9UITYZc006975
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 19:29:34 +0100
Received: from [167.87.33.44] ([167.87.33.44])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id x9UITXgO017475;
        Wed, 30 Oct 2019 19:29:34 +0100
Subject: Re: [PATCH] scripts/gdb: fix debugging modules compiled with hot/cold
 partitioning
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Kieran Bingham <kbingham@kernel.org>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20191028152734.13065-1-iii@linux.ibm.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <130e31f0-ce38-77cb-58a9-cedf3b0f8113@siemens.com>
Date:   Wed, 30 Oct 2019 19:29:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191028152734.13065-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.10.19 16:27, Ilya Leoshkevich wrote:
> gcc's -freorder-blocks-and-partition option makes it group frequently
> and infrequently used code in .text.hot and .text.unlikely sections
> respectively. At least when building modules on s390, this option is
> used by default.
> 
> gdb assumes that all code is located in .text section, and that .text
> section is located at module load address. With such modules this is no
> longer the case: there is code in .text.hot and .text.unlikely, and
> either of them might precede .text.
> 
> Fix by explicitly telling gdb the addresses of code sections.
> 
> It might be tempting to do this for all sections, not only the ones in
> the white list. Unfortunately, gdb appears to have an issue, when telling
> it about e.g. loadable .note.gnu.build-id section causes it to think that
> non-loadable .note.Linux section is loaded at address 0, which in turn
> causes NULL pointers to be resolved to bogus symbols. So keep using the
> white list approach for the time being.

Did you report this to gdb?

> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  scripts/gdb/linux/symbols.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
> index 7b7c2fafbc68..be984aa29b75 100644
> --- a/scripts/gdb/linux/symbols.py
> +++ b/scripts/gdb/linux/symbols.py
> @@ -99,7 +99,8 @@ lx-symbols command."""
>              attrs[n]['name'].string(): attrs[n]['address']
>              for n in range(int(sect_attrs['nsections']))}
>          args = []
> -        for section_name in [".data", ".data..read_mostly", ".rodata", ".bss"]:
> +        for section_name in [".data", ".data..read_mostly", ".rodata", ".bss",
> +                             ".text", ".text.hot", ".text.unlikely"]:
>              address = section_name_to_address.get(section_name)
>              if address:
>                  args.append(" -s {name} {addr}".format(
> 

Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
