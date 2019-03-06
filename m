Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FF6C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 00:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB3920684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 00:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTTGdQHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbfCFAVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 19:21:41 -0500
Received: from mail-pf1-f178.google.com ([209.85.210.178]:44567 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbfCFAVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 19:21:41 -0500
Received: by mail-pf1-f178.google.com with SMTP id a3so6981664pff.11;
        Tue, 05 Mar 2019 16:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=6vg1//HMXidMw97hpBoI1fG++c+nkNWEzFB9HrHqFLc=;
        b=hTTGdQHkSsqyx6ooSsFwFGpZIQ9J2kVaTtrCrr4hYeoZTedVnajzNGfu6HiXfQGAGF
         +6566nxMu82suy+TRJ3rZT6ot40AX+R13avC99Ck24ZfEsKV2bo0VsfGb/3mYgaNNP89
         rteme/btyXQcVydAhZeKpK89CgIMfsrWH5PIlJpBq8rT7Y6dhxtr9lTMTIVB+tklqdQC
         pe3M5hDnuSUotg/ElueATyvKjXwII0d/+heHbudgZOiGI0MstfRN3dFwF6TfLzSP7fJ9
         tj25JIqvtlHfjGO9M7W0mhzrXmtXl1YW5Ua2xhh9LKeH5llMOOED2mZiW0GgW8kil4ki
         PBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6vg1//HMXidMw97hpBoI1fG++c+nkNWEzFB9HrHqFLc=;
        b=qxu0NKCaTupl7GS4SEI9vdMwUOhE/YxfdXmcFzQ4tFTig7WhcpuRK+htZiFLfuerPE
         i9eftWKOF6WVeamxCG1Q/l0W3T8iF9O6I/o+mCs42N1VCmtGwmCpOjjMp8kdkK7EvEzt
         HFEvV4E8Elkbcn5U/F6CoIb3BLcT02VNV3jIakPh1r52dxVGMKMF89hM/RrRSiOXcraX
         D1ZDM/CT733hh5wI2jPuzUNeTnmD9P5QcfhRgs6pqtvcnvU2cKQnrP9oIzOD+86lzhlF
         Kp1WWDrnRCnX5ijRiqWzmJwf7WUSZRYBDDeMsU/RGT9SO6wyoAjLWEoiHcs+PLTJe+CC
         ZQWA==
X-Gm-Message-State: APjAAAXiYfWIz41sn6SugMtkPCv9xeQ9sh5DDriUCQseKNiL3USnAulV
        98LYZKloFfIz4uEQ2FcR4lI=
X-Google-Smtp-Source: APXvYqzik+LQSTPpOvBVCVZ8KlpHvaSOyS3bQxMBB9t3f7RTjYIpmSYfWBEzj1sHznISy8O/sEe+Yw==
X-Received: by 2002:a63:2808:: with SMTP id o8mr3777275pgo.188.1551831699992;
        Tue, 05 Mar 2019 16:21:39 -0800 (PST)
Received: from [192.168.0.16] (97-115-123-245.ptld.qwest.net. [97.115.123.245])
        by smtp.gmail.com with ESMTPSA id b70sm265244pfm.6.2019.03.05.16.21.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 16:21:39 -0800 (PST)
Subject: Re: [ovs-dev] openvswitch crash on i386
From:   Gregory Rose <gvrose8192@gmail.com>
To:     Joe Stringer <joe@ovn.org>,
        Christian Ehrhardt <christian.ehrhardt@canonical.com>
Cc:     "<dev@openvswitch.org>" <dev@openvswitch.org>,
        James Page <james.page@canonical.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        David Miller <davem@davemloft.net>
References: <20190305104010.6342e9b9@gollum>
 <CAATJJ0KgvC-j2egtq6G5M0jK5O04-xATEu_yDLvr53tJdFEzrQ@mail.gmail.com>
 <CAOftzPjJnBdHWgArGRhkSnQrqmUKvhxkO_eLth61-HEfZiAHUw@mail.gmail.com>
 <06cf4f57-e7ca-5ead-ed37-fb88255df78b@gmail.com>
Message-ID: <c34f0d39-1757-7030-7e60-e58246fdce1b@gmail.com>
Date:   Tue, 5 Mar 2019 16:21:37 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <06cf4f57-e7ca-5ead-ed37-fb88255df78b@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/5/2019 2:52 PM, Gregory Rose wrote:
>
> I have an i386 Ubuntu 18 VM to test this on.  I'll investigate and see 
> what I can find.
>
> - Greg
>

I have a repro.  It's not the same kernel (4.13 in my case) but looks 
like the same issue.

- Greg

