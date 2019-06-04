Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34848C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 19:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36652075B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 19:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="TJUKk9Ef";
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="X8bynUgE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfFDTjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 15:39:12 -0400
Received: from mx07-00252a01.pphosted.com ([62.209.51.214]:27362 "EHLO
        mx07-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726541AbfFDTjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 15:39:11 -0400
Received: from pps.filterd (m0102628.ppops.net [127.0.0.1])
        by mx07-00252a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x54JcBX3027962
        for <linux-kernel@vger.kernel.org>; Tue, 4 Jun 2019 20:39:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raspberrypi.org; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp;
 bh=UTu/iW6Gtp6K6tBR+5cJXfTvVrLTuenGsHDVI+Q1+SA=;
 b=TJUKk9Efj9DK5WyaU3pDTaCDkfnjo8n0Ucu/ZCirss4vuioY51eI3R3cDU4EaMKQ59Md
 urWeG2x8lVaIgGn7+IRPsiGFjz8Iz5bupZbOm+AJ4ILAN3HEzCXYfW7FlkYmjWyXQ7yj
 Vy5bHg7mCTvxnXQAN8r/iNqPwFdRj8xMsIVDdgxAl9cdHYgp9J/UpORIrto+JSHNHwMs
 6VMPbrRv0alsYpWvL9+5858zGXoPVMj39zzmTlf923OWSUUsw12pwM5whH9WC5bD9Wzt
 b7A/QvP9Jh1qvDZYfv2x4lzwII7jCVhp1lBX0gRsBkSdgyYpSLMffMFBIGEmolJ9dxQj Vw== 
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        by mx07-00252a01.pphosted.com with ESMTP id 2sues31qh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 20:39:08 +0100
Received: by mail-wm1-f71.google.com with SMTP id y204so397475wmd.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 12:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=UTu/iW6Gtp6K6tBR+5cJXfTvVrLTuenGsHDVI+Q1+SA=;
        b=X8bynUgEK1mG+lCexiK7h761LTign2OsrCIMxyA5EnHQKdsMauZ1xDBXxop9AGY9mj
         wG0nR9bSUkBc3ojHjr16DG9opwhaR6lUW2fi8iDuaN/LN+ycyyNewe2yFqBe6bOAVY7y
         GdKKVndqW+3+kwI0YjAcsuVAY2fFaWwzMc+3NVAZ7bfJ3LixScPgJaYt6ugdsU3MZFXJ
         1nJPI4g8ZkTR48OnrJZr+LbbfWaQtw+EpBINrun3+L2SPnaQrhSv2ujBaGee7STn9lvH
         AskLCxrti+LjiyHvYPXG1lENVZwdZhaUhdnv/kJpdX+5R2Xce2K2vHVg+gcCnQl2+SNw
         wnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=UTu/iW6Gtp6K6tBR+5cJXfTvVrLTuenGsHDVI+Q1+SA=;
        b=AkziROIe6wvejjGZXcla5vkNmkE7QTesr7djjxUgyqyimcK/19jFdySkqBa2+BxjTE
         W191geD34+XMGAJlqGCU2dg8WvqUTZQXFPxvgV0i7esoNwAgOkVVoSakvyQx7w80WfD7
         XlpQ1aY3VVu77bPlEg47hj14suevU59e46MF44QQz0Bz56SzT4JeLycQt4paPMQEAD3b
         jb3W8j6KfaZGfs9pkvE9FFXPd3tjPbppp7Pqrf4F7hxdNnUyTIlkdtrXW1mvLVeLy1EI
         TUf0+hLZAMaEmYaD7VPr0TPxD/vl46FiFg0S3wTQ2+hvsKN+rDVDZ8G2H93cw7+hXJ1R
         vJOg==
X-Gm-Message-State: APjAAAWDTKdziPu3hy4/KA+MYvpHGvayVqgBj6HBidfHPxrbX4n6t9T9
        32BUQgaz2l5AVQ6Nhv7nuABRO0jFrp6mFIRqFW1gaoXRbU7lusYJ9FMb9+UIvCZ47adfMYukIHa
        dElVOf7GfW38qxHDKRLvTUN4Z
X-Received: by 2002:a5d:63cb:: with SMTP id c11mr21713039wrw.65.1559677147231;
        Tue, 04 Jun 2019 12:39:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxH7rWx/dzukCtGkybMmM09pk3h5WIfa3spCxd7vBJqXBbRDcI5BmAKsGCU27uLpH5zPz+x3w==
X-Received: by 2002:a5d:63cb:: with SMTP id c11mr21713026wrw.65.1559677146954;
        Tue, 04 Jun 2019 12:39:06 -0700 (PDT)
Received: from PhilsPB.lan (cpc129774-papw8-2-0-cust832.know.cable.virginm.net. [86.12.207.65])
        by smtp.gmail.com with ESMTPSA id y12sm15747271wrh.40.2019.06.04.12.39.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 12:39:06 -0700 (PDT)
Subject: Re: Dynamic overlay failure in 4.19 & 4.20
To:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <c5af11eb-afe5-08c4-8597-3195c25ba1d5@raspberrypi.org>
 <4d5b9fba-3879-0729-119a-f7d585a74cc1@gmail.com>
From:   Phil Elwell <phil@raspberrypi.org>
Message-ID: <db0fdbc6-33ce-d7b6-c807-896905fe4a90@raspberrypi.org>
Date:   Tue, 4 Jun 2019 20:39:04 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <4d5b9fba-3879-0729-119a-f7d585a74cc1@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-04_12:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

On 04/06/2019 19:20, Frank Rowand wrote:
> Hi Phil,
> 
> On 6/4/19 5:15 AM, Phil Elwell wrote:
>> Hi,
>>
>> In the downstream Raspberry Pi kernel we are using configfs to apply overlays at
>> runtime, using a patchset from Pantelis that hasn't been accepted upstream yet.
>> Apart from the occasional need to adapt to upstream changes, this has been working
>> well for us.
>>
>> A Raspberry Pi user recently noticed that this mechanism was failing for an overlay in
>> 4.19. Although the overlay appeared to be applied successfully, pinctrl was reporting
>> that one of the two fragments contained an invalid phandle, and an examination of the
>> live DT agreed - the target of the reference, which was in the other fragment, was
>> missing the phandle property.
>>
>> 5.0 added two patches - [1] to stop blindly copying properties from the overlay fragments
>> into the live tree, and [2] to explicitly copy across the name and phandle properties.
>> These two commits should be treated as a pair; the former requires the properties that
>> are legitimately defined by an overlay to be added via a changeset, but this mechanism
>> deliberately skips the name and phandle; the latter addresses this shortcoming. However,
>> [1] was back-ported to 4.19 and 4.20 but [2] wasn't, hence the problem.
> 
> I have relied upon Greg's statement that he would handle the stable kernels, and that
> the process of doing so would not impact (or would minimally impact) maintainers.  If
> I think something should go into stable, I will tag it as such, but otherwise I ignore
> the stable branches.  For overlay related code specifically, my base standard is that
> overlay support is an under development, not yet ready for prime time feature and thus
> I do not tag my overlay patches for stable.
> 
> Your research and analysis above sound like there are on target (thanks for providing
> the clear and detailed explanation!), so if you want the stable branches to work for
> overlays (out of tree, as you mentioned) I would suggest you email Greg, asking that
> the second patch be added to the stable branches.  Since the two patches you pointed
> out are put of a larger series, you might also want to check which of the other
> patches in that series were included in stable or left out from stable.  My suggestion
> that you request Greg add the second patch continues to rely on the concept that
> stable does not add to my workload, so I have not carefully analyzed whether adding
> the patch actually is the correct and full fix, but instead am relying on your good
> judgment that it is.

<useful context snipped>

Thank you - I'll email Greg directly as you suggest, with your answer as supporting
evidence.

Phil
