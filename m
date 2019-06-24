Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E57C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C55B02089F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfFXHDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 03:03:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59998 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfFXHDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 03:03:23 -0400
Received: from mail-pf1-f199.google.com ([209.85.210.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hfJ0b-0000cT-52
        for linux-kernel@vger.kernel.org; Mon, 24 Jun 2019 07:03:21 +0000
Received: by mail-pf1-f199.google.com with SMTP id x9so8989378pfm.16
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 00:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VgUEc8232HEbDcNbWBe1DLHeVAFqFByxVy9pHNe5ej4=;
        b=okWhpAV279uL8YA3NeNq3SQ8HmiwgZhKiY3GbgDNgp3djZTfwNKiuj1NX6MQozY6NQ
         VgNgEzlaZOsLRIsOeOsv02cbUqiJ9PYM/Xwkzs+qgle8qIr3qH9QCSAl892Xn68Jmx03
         Hg8ABVXvB6/33qsmAhV6D8hD1398V3DxeKgepVw/4RV+EaTSfglmX0nfMJfIWVBRPMVZ
         O2Y+62DDe+gbLvMI1dlq+R5S9+N2c4EmUSjyjzF/jFKWXVs4A06MdBkl/IA5B9XYGWl7
         88ECuksorF1KuP6238E6LtwtjGmfYGuKHfoQx9O+PYxrWK/7lRCTFExqT7TJnDxQGOFn
         DRvQ==
X-Gm-Message-State: APjAAAXW7mQ7Wp+e4G5ZqoGu9Z52EhAAzzyp58YCg3Yoaq1Rb7qDH/ZK
        et+QpsOS8GPcZ+js1cLpgubYVNrXSHFKy3elo/p7ZFluIattxx7Ybi/wDqD+ZJhmL8fL5XfBh8g
        T40wbKAbViVdkYFjEPXjH1x6acXqsHvqJdpRDgkhaMw==
X-Received: by 2002:a17:902:296a:: with SMTP id g97mr72320031plb.115.1561359799845;
        Mon, 24 Jun 2019 00:03:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyShOHIK0XoPW/T+X8rCgw0nfFWgSa/8lV7g4xHQe7ILDTZirejduPKv2P9rOxAqINp3wSXSQ==
X-Received: by 2002:a17:902:296a:: with SMTP id g97mr72320003plb.115.1561359799577;
        Mon, 24 Jun 2019 00:03:19 -0700 (PDT)
Received: from 2001-b011-380f-3511-4d72-4f7c-d6a5-6121.dynamic-ip6.hinet.net (2001-b011-380f-3511-4d72-4f7c-d6a5-6121.dynamic-ip6.hinet.net. [2001:b011:380f:3511:4d72:4f7c:d6a5:6121])
        by smtp.gmail.com with ESMTPSA id p3sm10353968pgh.90.2019.06.24.00.03.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 00:03:18 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: Opportunistic S0ix blocked by e1000e when ethernet is in use
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <074E1145-A512-4835-9A6D-8FB6634DBD3C@canonical.com>
Date:   Mon, 24 Jun 2019 15:03:16 +0800
Cc:     Anthony Wong <anthony.wong@canonical.com>,
        intel-wired-lan@lists.osuosl.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8bit
Message-Id: <E2D5225B-D683-4895-AC4F-EE01C339262B@canonical.com>
References: <074E1145-A512-4835-9A6D-8FB6634DBD3C@canonical.com>
To:     jeffrey.t.kirsher@intel.com
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeffrey,

at 19:08, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:

> Hi Jeffrey,
>
> There are several platforms that uses e1000e can’t enter Opportunistic  
> S0ix (PC10) when the ethernet has a link partner.
>
> This behavior also exits in out-of-tree e1000e driver 3.4.2.1, but seems  
> like 3.4.2.3 fixes the issue.
>
> A quick diff between the two versions shows that this code section may be  
> our solution:
>
>         /* Read from EXTCNF_CTRL in e1000_acquire_swflag_ich8lan function
>          * may occur during global reset and cause system hang.
>          * Configuration space access creates the needed delay.
>          * Write to E1000_STRAP RO register E1000_PCI_VENDOR_ID_REGISTER value
>          * insures configuration space read is done before global reset.
>          */
>         pci_read_config_word(hw->adapter->pdev, E1000_PCI_VENDOR_ID_REGISTER,
>                              &pci_cfg);
>         ew32(STRAP, pci_cfg);
>         e_dbg("Issuing a global reset to ich8lan\n");
>         ew32(CTRL, (ctrl | E1000_CTRL_RST));
>         /* cannot issue a flush here because it hangs the hardware */
>         msleep(20);
>
>         /* Configuration space access improve HW level time sync mechanism.
>          * Write to E1000_STRAP RO register E1000_PCI_VENDOR_ID_REGISTER
>          * value to insure configuration space read is done
>          * before any access to mac register.
>          */
>         pci_read_config_word(hw->adapter->pdev, E1000_PCI_VENDOR_ID_REGISTER,
>                              &pci_cfg);
>         ew32(STRAP, pci_cfg);

Turns out the "extra sauce” is not this part, it’s called “Dynamic LTR  
support”.

>
> Is there any plan to support this in the upstream kernel?

Is there any plan to support Dynamic LTR in upstream e1000e?

Kai-Heng

>
> Kai-Heng


