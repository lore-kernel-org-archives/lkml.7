Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42860C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 06:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 106E3222C6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 06:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569477705;
	bh=4zJiZNyI96z4hhSMN+eDhzrI9BY8E8PsC3pvObNfH4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PCLcFXAuHMBgjFCMjkGiW2rGpvyAluURiQhlX51lv8eF60fYnFnCex+/Ny0EL6tpV
	 1aR+yaE03g+88iHYWh+pTfRGPA2/J/gGwOdSUMTY/1oqqu38P1Lvv0r3EODyG5aq9g
	 Zq8sCQVa1IaMaAb5rLOMUa+xwfq1Bv+iUq9o9Ei4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392444AbfIZGBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 02:01:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37577 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730826AbfIZGBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 02:01:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id i1so1187722wro.4;
        Wed, 25 Sep 2019 23:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5oH/HLfRBCqxgKWi3tjBpSapnk9Frw2tXRaiX1Zmw4E=;
        b=gBgw7Amuzy/NoKqBCW+5HwcfjCh3kwDKHQJiGg3wmYOaxpSiDh6rNLjKm8mq5kQsIn
         Ex/6Q0G01oXlWb/Gne5IqaS9fMWocf6D8NSpUy1o3l3O8vXhzIIDIDYngNUAmT7t+o51
         P49wtfWTPtqNDZhimj44BxotkakxWcz4pieHzli2QqmowUVt6lrQ+rxfsrkatN5kKn9R
         XbVFauCzKWcw7Xh9H3IcjPRnwBV+4+6jhrqGe5M/AaZyazaZvAi2jh9Tzxrd6884Oc0S
         gSGO9xYMSEJ+NW1o8AW9aOiFb2kMF7dOD9cFvs1bwz6lgT1+MLI6/l0ieaKTIFmsHLB/
         mKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5oH/HLfRBCqxgKWi3tjBpSapnk9Frw2tXRaiX1Zmw4E=;
        b=S6UHW0alk2CZACfHSpp6H22C+5qf+lrYST+lmiON7tZmvjDdFMIAlPk0V0yDBDqhAe
         zDFSO5VK+sIPneGuotxEG17zXE645ZsxdyPjOfhgmfDVn3LNrQ+7M0X895kiKG4arqML
         b55MzJVkwcfAB7oNajry7eu4y+ITJ6683pmXgx+cCTvNrao92e3Z7nX7v60hS3jw8Ms4
         lHxo6dp6c9gXGiq/kHPwyKZvYnl9o4IQIcnQCr+kz3c4a+tJbGdIP5FP2jSwL4N2hakd
         Ug3bBTLl5Ctq7Rtrt2ThXDQtlK5g40CCMztj1AcB9GGsg58CeiAZOwBmWO65jgyYklRg
         dZZQ==
X-Gm-Message-State: APjAAAWpWm6QV0DWXf4U2jEFpo7Khn9rTuMk0iGU9U5kkXIjS18iPPz5
        5e6PLdE/5sykv/xFc0z3wRc=
X-Google-Smtp-Source: APXvYqy+xB6MkLVlCESch9AVLchqZp/q9OI7Q80xwYXqSGfvhr/QbsfJ4GAii03VeWmRWubIHE9TfQ==
X-Received: by 2002:a5d:560a:: with SMTP id l10mr1401864wrv.387.1569477702427;
        Wed, 25 Sep 2019 23:01:42 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id s1sm2393696wrg.80.2019.09.25.23.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 23:01:41 -0700 (PDT)
Date:   Thu, 26 Sep 2019 08:01:39 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Cao jin <caoj.fnst@cn.fujitsu.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, corbet@lwn.net
Subject: Re: [RFC PATCH] x86/doc/boot_protocol: Correct the description of
 "reloc"
Message-ID: <20190926060139.GA100481@gmail.com>
References: <20190926042116.17929-1-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926042116.17929-1-caoj.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Cao jin <caoj.fnst@cn.fujitsu.com> wrote:

> The fields marked with (reloc) actually are not dedicated for writing,
> but communicating info for relocatable kernel with boot loaders. For
> example:
> 
>     ============    ============
>     Field name:     pref_address
>     Type:           read (reloc)
>     Offset/size:    0x258/8
>     Protocol:       2.10+
>     ============    ============
> 
>     ============    ========================
>     Field name:     code32_start
>     Type:           modify (optional, reloc)
>     Offset/size:    0x214/4
>     Protocol:       2.00+
>     ============    ========================
> 
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> ---
> Unless I have incorrect non-native understanding for "fill in", I think
> this is inaccurate.
> 
>  Documentation/x86/boot.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
> index 08a2f100c0e6..a611bf04492d 100644
> --- a/Documentation/x86/boot.rst
> +++ b/Documentation/x86/boot.rst
> @@ -243,7 +243,7 @@ bootloader ("modify").
>  
>  All general purpose boot loaders should write the fields marked
>  (obligatory).  Boot loaders who want to load the kernel at a
> -nonstandard address should fill in the fields marked (reloc); other
> +nonstandard address should consult with the fields marked (reloc); other
>  boot loaders can ignore those fields.
>  
>  The byte order of all fields is littleendian (this is x86, after all.)

Well, this documentation is written from the point of view of a 
*bootloader*, not the kernel. So the 'fill in' says that the bootloader 
should write those fields - which is correct, right?

Thanks,

	Ingo
