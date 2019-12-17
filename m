Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813D7C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 545F4206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yuunl+mV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbfLQPTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 10:19:55 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:35785 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbfLQPTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 10:19:54 -0500
Received: by mail-oi1-f179.google.com with SMTP id k4so1274307oik.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 07:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H8azu2o1Iq/reNcvhoSocAVOxEQHSQBRnVTNzbUF3Uc=;
        b=Yuunl+mVntpbKZNnHvL9W6ngR9Q38K7dedOy3fCB93uINumpD90/kZQ/2RLGaPHbC1
         CvBMy+fFpjk2nNyMJE2AxBIwfktv2bKuixUmH9TrEcMswxMblocMPZ/JKfLNCKSM9ZhL
         MLo5cmftOn3npenO+04AoRAATq6eJ6sKqscCEDbKOBRTk2rys5pAmtqEY9CrLerGgWS9
         akbOV5beLokCnkf9QywhLyvUEvRel/4GsydJB3f55LLDIq0d89eCCSKe9Ul8ilnB5CNC
         EiGpdWYwQJj6exlFfowi32SwRnIRqMSXfmtPsbHbUWauwZ4E18TVjG9haaE9yD0/1MjC
         y16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H8azu2o1Iq/reNcvhoSocAVOxEQHSQBRnVTNzbUF3Uc=;
        b=ae22SQv1FHbj0djgCWjLNqAPttn25laEBL2SoYR9yAODZKUKH+vwrrvjLhT1pKnGfP
         vHpvoivqjM1opAQhas33GUuNTU4qKWQPBzaPbVMkW/gDWh1AulEKvd2Yo4yPKlKJoPbs
         Z4b/uY4AsZSHF9mrIFfD1gfdRE83YkdSwGwH9tSWSN8blGjsv3EAIqiDmRof9nhuLkw7
         QcYulXnmqlp64v1eeqdQy35XhD/oyAoNvLF4sHyc2ZDwoEHX2U2xqz6LXBaN23vdLPy0
         lttHoffVSl2a1/wMYA/Qm2y5UsVoOVgDNzKBB23268zRfTngT9AXftVMoUw7ul92J8k8
         Ysvg==
X-Gm-Message-State: APjAAAVSyHSFF4Mzt/00Y6rij1mhB5Z2r6h6sHFY9mzS8DR2KhSP2Xx3
        pFiNHdFvr/Gj0FBe/mVFczy4EQqJ
X-Google-Smtp-Source: APXvYqx1GPeMIumZLhZkdd4Qm8fAnZjPDCzJ3pnTmxK4rc+3eBXq7XAczpUtVEkagQ+aQ3M8RsdVEg==
X-Received: by 2002:aca:4a08:: with SMTP id x8mr1794024oia.39.1576595993424;
        Tue, 17 Dec 2019 07:19:53 -0800 (PST)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id n25sm7966735oic.6.2019.12.17.07.19.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 07:19:52 -0800 (PST)
Subject: Re: VirtualBox module build breakage since commit 39808e451fdf
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <392d86d2-76a4-03d2-5517-3c22bcf3e535@lwfinger.net>
 <CAK7LNARUhrC92HM7DVBVUbPVpS9Q_svb-h6EZ496fpr5JFdPdg@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <6a0f3245-eaaf-ebff-1122-89d56baf4b1d@lwfinger.net>
Date:   Tue, 17 Dec 2019 09:19:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNARUhrC92HM7DVBVUbPVpS9Q_svb-h6EZ496fpr5JFdPdg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/19 11:11 PM, Masahiro Yamada wrote:
> Hi.
> 
> On Mon, Dec 16, 2019 at 11:48 AM Larry Finger <Larry.Finger@lwfinger.net> wrote:
>>
>> Hi,
>>
>> Since commit 39808e451fdf ("kbuild: do not read
>> $(KBUILD_EXTMOD)/Module.symvers"), some of the modules for VirtualBox have
>> failed to build. There are at least 3 such modules, namely vboxdrv, vboxnetflt,
>> and vboxnetadp.
> 
> As the section 6.3 of Documentation/kbuild/modules.rst says,
> the best practice is to put the related modules into the same source
> tree, and then do like this:
> 
>    obj-m := vboxdrv/  vboxnetfit/  vboxnetadp/
> 
> 
> 
> If you want to maintain the three separately,
> as 39808e451fdf mentions, you can useKBUILD_EXTRA_SYMBOLS.
> KBUILD_EXTRA_SYMBOLS was added more than a decade.
> So, you should be able to use it for your modules.
> 
> I think it is a cleaner solution than
> copying around Module.symvers in your build tree.

Masahiro,

Thank you for your prompt reply. Once I got it right, the KBUILD_EXTRA_SYMBOLS 
method works. The debugging was slow due to the problem area happening near the 
end of a 45-minute build, but I now have a solution that works for all kernels.

Thanks again,

Larry
