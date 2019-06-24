Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFC1C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 15:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70994205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 15:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbfFXPGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 11:06:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44786 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbfFXPGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 11:06:54 -0400
Received: from mail-pg1-f197.google.com ([209.85.215.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hfQYW-0005cw-Hi
        for linux-kernel@vger.kernel.org; Mon, 24 Jun 2019 15:06:52 +0000
Received: by mail-pg1-f197.google.com with SMTP id b10so9527819pgb.22
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 08:06:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=y+QoeWvPrccIYvLGropH5jHS2w+2t9wnJi4dhuZVRGQ=;
        b=cEbgzzoJMgpYEse9wywORAsz3raQm1xpMXerbl9niE48tljIMHf/THxJtN9PZm+cME
         HfI3pAD81o9gz1o7A+9exWIQogP9OIcE9XyNkKPLs9cdE6+iL+B20Rm4iYES5oNDKm5l
         AjadltzrCjVZmGsLfyzNsLp6FuOkpgYMFwu4YQOIGA/j7AZSfA8AgCDLmdc9zofimNxG
         9M/UsIHMI+byhzznT8oTnwMJR3bfxTN60NEbhkzBBfVWywUPf6ujTSWAzlouNtcSTXHn
         pLKQ7wIAtAFa26tv/81fi2X6dXX/PHWPN/JxHpXbGFKmEtn36cWHm3Iskj4lEktsyXFB
         BL/A==
X-Gm-Message-State: APjAAAUOaDXaP8nSXUP5mCzjDKaWKuWSzjBtSSRPwAlUadbkXiaXxlzf
        ql2eVyjCNoRiomxhEs9D/JuzqJw8ApuxEYuWqhHFgw+vK7DUW3w7pBVGGFJp04tb6vK5XksR+j9
        0kQx7b+5I/qQsqaayJK3Fk+9GcAwfISQ9go1iuaWgYQ==
X-Received: by 2002:a17:902:7891:: with SMTP id q17mr529852pll.236.1561388811270;
        Mon, 24 Jun 2019 08:06:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqycqXZEKk6KVYNmdZDrNEMKxNR2NCHwbsqtBSv0eoZBLh8gAr2zeCpglkeBUrZtvGNFYauSHw==
X-Received: by 2002:a17:902:7891:: with SMTP id q17mr529820pll.236.1561388810970;
        Mon, 24 Jun 2019 08:06:50 -0700 (PDT)
Received: from 2001-b011-380f-3511-4d72-4f7c-d6a5-6121.dynamic-ip6.hinet.net (2001-b011-380f-3511-4d72-4f7c-d6a5-6121.dynamic-ip6.hinet.net. [2001:b011:380f:3511:4d72:4f7c:d6a5:6121])
        by smtp.gmail.com with ESMTPSA id 23sm12968842pfn.176.2019.06.24.08.06.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 08:06:50 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [Intel-wired-lan] Opportunistic S0ix blocked by e1000e when
 ethernet is in use
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <95f88f45-fd6c-52e4-de8c-2db1b4c6c04e@intel.com>
Date:   Mon, 24 Jun 2019 23:06:44 +0800
Cc:     jeffrey.t.kirsher@intel.com, intel-wired-lan@lists.osuosl.org,
        Anthony Wong <anthony.wong@canonical.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8bit
Message-Id: <E8C45269-819C-41E0-A3D3-AA98710DBA4C@canonical.com>
References: <074E1145-A512-4835-9A6D-8FB6634DBD3C@canonical.com>
 <E2D5225B-D683-4895-AC4F-EE01C339262B@canonical.com>
 <95f88f45-fd6c-52e4-de8c-2db1b4c6c04e@intel.com>
To:     "Neftin, Sasha" <sasha.neftin@intel.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 19:56, Neftin, Sasha <sasha.neftin@intel.com> wrote:

> On 6/24/2019 10:03, Kai-Heng Feng wrote:
>> Hi Jeffrey,
>> at 19:08, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>>> Hi Jeffrey,
>>>
>>> There are several platforms that uses e1000e can’t enter Opportunistic  
>>> S0ix (PC10) when the ethernet has a link partner.
>>>
>>> This behavior also exits in out-of-tree e1000e driver 3.4.2.1, but  
>>> seems like 3.4.2.3 fixes the issue.
>>>
>>> A quick diff between the two versions shows that this code section may  
>>> be our solution:
>>>
>>>         /* Read from EXTCNF_CTRL in e1000_acquire_swflag_ich8lan function
>>>          * may occur during global reset and cause system hang.
>>>          * Configuration space access creates the needed delay.
>>>          * Write to E1000_STRAP RO register E1000_PCI_VENDOR_ID_REGISTER value
>>>          * insures configuration space read is done before global reset.
>>>          */
>>>         pci_read_config_word(hw->adapter->pdev, E1000_PCI_VENDOR_ID_REGISTER,
>>>                              &pci_cfg);
>>>         ew32(STRAP, pci_cfg);
>>>         e_dbg("Issuing a global reset to ich8lan\n");
>>>         ew32(CTRL, (ctrl | E1000_CTRL_RST));
>>>         /* cannot issue a flush here because it hangs the hardware */
>>>         msleep(20);
>>>
>>>         /* Configuration space access improve HW level time sync mechanism.
>>>          * Write to E1000_STRAP RO register E1000_PCI_VENDOR_ID_REGISTER
>>>          * value to insure configuration space read is done
>>>          * before any access to mac register.
>>>          */
>>>         pci_read_config_word(hw->adapter->pdev, E1000_PCI_VENDOR_ID_REGISTER,
>>>                              &pci_cfg);
>>>         ew32(STRAP, pci_cfg);
>> Turns out the "extra sauce” is not this part, it’s called “Dynamic LTR  
>> support”.
>> >>
>>> Is there any plan to support this in the upstream kernel?
>> Is there any plan to support Dynamic LTR in upstream e1000e?
> Dynamic LTR is not stable solution. So, we can not put this solution to  
> upstream. I hope we will be able to fix this in HW for a future projects.

Does this mean current generation hardware won’t get the fix?

> S0ix support is under discussion with our architecture. We will try  
> enable S0ix in our e1000e OOT driver as first step.

Is it possible to add Dynamic LTR as an option so users and downstream  
distros can still benefit from it?

Kai-Heng

>> Kai-Heng
>>> Kai-Heng
>> _______________________________________________
>> Intel-wired-lan mailing list
>> Intel-wired-lan@osuosl.org
>> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
>
> Thanks
> Sasha


