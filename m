Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849F9C48BD3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 02:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 589772183F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 02:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMMUaqVA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfF0Cz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 22:55:58 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35009 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfF0Cz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 22:55:57 -0400
Received: by mail-qk1-f195.google.com with SMTP id l128so505395qke.2;
        Wed, 26 Jun 2019 19:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lswDpvtKF8o6UZb/0KjUEuigeQB8Cet2e2NAoq7mH9Q=;
        b=VMMUaqVAcu3KOBN461WvWtatLU/ToQeHDJCisXMAOnXI+Fp9kqy0nh4k+vmXkaewg1
         xW5yNZLCwivwVRM37/sVSz20lfuTTC8gBviW4Zdb4ZJmcaBpuE/zV3q325F/IRNEzSft
         iTfy7hYRvB8H5bq+Uu+nGx8nxr8mqXRp++zoCdhDehk5uUFfAOBR8NsQF8EaYUdR4HRm
         CTkfXJFtZo7dkRT0f3pVrlGbpNSD+Dc0pNHtB8jZP55i6peDnJll3s1ekFIo/30nN+ys
         3mA/pie+tMxhko3P7ZWeHOaxuY5wJiiPb7xOa34JQoasa3PPsZDSvVhUOWTpdI2funAG
         QTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lswDpvtKF8o6UZb/0KjUEuigeQB8Cet2e2NAoq7mH9Q=;
        b=szz+mDsDmniykiCpWbHUKTBu//4VtSbHBDn5hlsF2mFm7ulOxiUOKpsM75Em6kayOl
         RQnytAZRk0vzwsXF/3pvqYkXXg6VEO4JzhaPOk00/+Ci5xyF8JSTJTTVwlqeeB+JABoo
         eOHIQb/7doDy4Stv5qMd98KtB/LjKgllBRwbaDID9YM9QjVcg9tk1rETWsutt+k3XsaA
         ZoNX5cdUfRYseLCSeh71zFwu/GUDKoG8mnK2NXzV5g2d+jQ74unjaYRSvhjvFyCyukCd
         icSkk3TsxTugROk7YMksO4tfJLP9GMgi+z8MAwlE3viEFQ1s3K1Bhxe/faoWqBzNaZJc
         nFHA==
X-Gm-Message-State: APjAAAVRGi23nRrBfqDUGg7gE0WYjnza6jL0w8d/uB/kaPCSuzRqemXV
        nBOgNHqdnTCdpObLgtN1iqo=
X-Google-Smtp-Source: APXvYqydouuDUKdeDB/W+gDn3VulcR/CvV/9h3U6st0G/oELazvrNHAFX09M/2VJhsnKaZLszAz6EA==
X-Received: by 2002:a37:815:: with SMTP id 21mr1231815qki.257.1561604156989;
        Wed, 26 Jun 2019 19:55:56 -0700 (PDT)
Received: from [192.168.43.210] (mobile-166-171-59-11.mycingular.net. [166.171.59.11])
        by smtp.gmail.com with ESMTPSA id u4sm333202qkb.16.2019.06.26.19.55.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 19:55:56 -0700 (PDT)
Subject: Re: [RFC PATCH 00/11] tracing: of: Boot time tracing using devicetree
To:     Rob Herring <robh+dt@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
References: <156113387975.28344.16009584175308192243.stgit@devnote2>
 <CAL_JsqJOc+tkFEGcc+KN0RE8Xjg_i9icPWZ37Ynk_9sR2X1Uwg@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <9f0cfc20-213a-b8ad-5a7f-ce811d0d5513@gmail.com>
Date:   Wed, 26 Jun 2019 19:55:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJOc+tkFEGcc+KN0RE8Xjg_i9icPWZ37Ynk_9sR2X1Uwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/19 2:58 PM, Rob Herring wrote:
> On Fri, Jun 21, 2019 at 10:18 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>>
>> Hi,
>>
>> Here is an RFC series of patches to add boot-time tracing using
>> devicetree.
>>
>> Currently, kernel support boot-time tracing using kernel command-line
>> parameters. But that is very limited because of limited expressions
>> and limited length of command line. Recently, useful features like
>> histogram, synthetic events, etc. are being added to ftrace, but it is
>> clear that we can not expand command-line options to support these
>> features.
>>
>> Hoever, I've found that there is a devicetree which can pass more
>> structured commands to kernel at boot time :) The devicetree is usually
>> used for dscribing hardware configuration, but I think we can expand it
>> for software configuration too (e.g. AOSP and OPTEE already introduced
>> firmware node.) Also, grub and qemu already supports loading devicetree,
>> so we can use it not only on embedded devices but also on x86 PC too.
> 
> Do the x86 versions of grub, qemu, EFI, any other bootloader actually
> enable DT support? I didn't think so. Certainly, an x86 kernel doesn't
> normally (other than OLPC and ce4100) have a defined way to even pass
> a dtb from the bootloader to the kernel and the kernel doesn't
> unflatten the dtb.
> 
> For arm64, the bootloader to kernel interface is DT even for ACPI
> based systems. So unlike Frank, I'm not completely against DT being
> the interface, but it's hardly universal across architectures and
> something like this should be. Neither making DT the universal kernel
> boot interface nor creating some new channel as Frank suggested seems
> like an easy task.
> 
> Rob
> 
Agreed, creating a new generic channel is not a small or easy task.  And
if it does get added it should support several different use cases that
have been expressed over the last few years.  Or have enough good
architecturfe such thatvit is easy to add support for other use cases
without impacting previously existing cases.

-Frank
