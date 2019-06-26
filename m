Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1538C4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 05:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C151E208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 05:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfFZFtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 01:49:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38670 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfFZFtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 01:49:20 -0400
Received: from mail-pl1-f200.google.com ([209.85.214.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hg0o2-0007jK-Dn
        for linux-kernel@vger.kernel.org; Wed, 26 Jun 2019 05:49:18 +0000
Received: by mail-pl1-f200.google.com with SMTP id n1so753042plk.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 22:49:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=12ANf5jkxiue7axL1Y5xhLlkcaf3kHXDuZtfoS2gzUA=;
        b=lgHd/8gQh1nWwigD2w2axGVyeBdtEJyEurwJXqLwEVAuqY9Bra35kwuYOGS1VjgXoR
         6MoJwIDKxiaMtiU1t/yFhL2oXWsSKdsVk3hF8FiE4MHmZRXrTzcxVUNJhbfY1u+A/hZ1
         DTv//8V6fM1SSosRTIXdpBB9kdAS+btgK/Kd21to7JtB+EU4NBBTkh4PagoFQRzlgwTy
         UJJW5LKugO/9tx4xYNTygLDPfm5fUNePrX2DJ98LjGJ1V5nQ4M9fg468INmNt47PJnRp
         cIgeVHyRgxrpBY5xtWuEgqQhmJXn8wnmjkcqQjOLsRwK0jcHp6ufTGnUzZytvuqKHP5o
         hkJg==
X-Gm-Message-State: APjAAAXeCDQeiLZqrohj61bZ+U/XCyYMehBw+sFw7fTBc6m5eTrmkowz
        MrysqIRp/DfIHf/2i/0Xe7Ogk18uB5A+qycXPLl+euo7lqXvOy/0sIj11TWMgRzFgIcZwpKLyDm
        h0MXQ+5Xa1Xz9mCJKGT9gK2xSDfxkeETQgAmXZeViNA==
X-Received: by 2002:a17:902:9688:: with SMTP id n8mr3116872plp.227.1561528156893;
        Tue, 25 Jun 2019 22:49:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwee9bWoCIWpnXOMY7SxZkgP4ELM68w+FNl6jhugNxsK+602xd1wI/6pPbktKeAaH3SPdhALQ==
X-Received: by 2002:a17:902:9688:: with SMTP id n8mr3116854plp.227.1561528156633;
        Tue, 25 Jun 2019 22:49:16 -0700 (PDT)
Received: from [10.101.46.178] (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id r15sm19728330pfh.121.2019.06.25.22.49.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 22:49:16 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [Intel-wired-lan] Opportunistic S0ix blocked by e1000e when
 ethernet is in use
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <dfd57ef4-08bd-53cf-1f0a-86edc5bc0a67@intel.com>
Date:   Wed, 26 Jun 2019 13:49:13 +0800
Cc:     jeffrey.t.kirsher@intel.com, intel-wired-lan@lists.osuosl.org,
        Anthony Wong <anthony.wong@canonical.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8bit
Message-Id: <8C7BCE85-D027-4C0C-BD46-619FAD0E6AB8@canonical.com>
References: <074E1145-A512-4835-9A6D-8FB6634DBD3C@canonical.com>
 <E2D5225B-D683-4895-AC4F-EE01C339262B@canonical.com>
 <95f88f45-fd6c-52e4-de8c-2db1b4c6c04e@intel.com>
 <E8C45269-819C-41E0-A3D3-AA98710DBA4C@canonical.com>
 <dfd57ef4-08bd-53cf-1f0a-86edc5bc0a67@intel.com>
To:     "Neftin, Sasha" <sasha.neftin@intel.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 6:25 PM, Neftin, Sasha <sasha.neftin@intel.com> wrote:

> On 6/24/2019 18:06, Kai-Heng Feng wrote:
>> at 19:56, Neftin, Sasha <sasha.neftin@intel.com> wrote:
[Snipped]
> Current HW have a limitation. Please, try follow workaround on your  
> platform: echo 3 > /sys/kernel/debug/pmc_core/ltr_ignore

Yes, this does the trick.

On 4.15 based kernel I can see the SoC enters PC10 but SLP_S0 is not  
asserted.

On mainline kernel the SoC, PC10 is hit and SLP_S0 is asserted. Once SLP_S0  
is asserted the SSH connection becomes really sluggish.

>> >> S0ix support is under discussion with our architecture. We will try
>>> enable S0ix in our e1000e OOT driver as first step.
>> Is it possible to add Dynamic LTR as an option so users and downstream  
>> distros can still benefit from it?
> As I said before, this is not a stable solution. No guarantee that HW  
> will work as properly.

Can you describe the symptom of "HW will work as properly”? Is this the  
sluggish connection I observed?

Kai-Heng

>> Kai-Heng
>>>> Kai-Heng
>>>>> Kai-Heng
>>>> _______________________________________________
>>>> Intel-wired-lan mailing list
>>>> Intel-wired-lan@osuosl.org
>>>> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
>>>
>>> Thanks
>>> Sasha


