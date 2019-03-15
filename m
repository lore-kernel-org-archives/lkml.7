Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C975C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 11:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42819218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 11:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbfCOLIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 07:08:38 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38609 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbfCOLIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 07:08:38 -0400
Received: from mail-pf1-f200.google.com ([209.85.210.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1h4khY-0007qO-N6
        for linux-kernel@vger.kernel.org; Fri, 15 Mar 2019 11:08:36 +0000
Received: by mail-pf1-f200.google.com with SMTP id t5so5083080pfh.18
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 04:08:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=Q/BB9g5sJonPXOr1Vga0xMJQ1xeE92hF0KjUizkB/gk=;
        b=BVt/9J+sgLF/P0mcIj4PivjVo+cFULeSyJt5jAruU4uJ/oR5b+nGRmF+pR3dGjcJYq
         8ERjKLpeKNkKwEGEEQPXw8ptP8/k8PJ2Ev57ELMoY9JWV947qh9FKUS61I+9eb/pkIs0
         grHGOl81CABuL5/3H9YaeyXhh5cVlFkQPEvTRnq3exVOqBejwP8ajutwp4Ihn5bI9kCw
         cUyO2IJYGykyEHUXQFBNizt6SXsRWCpAG3DmlYnsH2s3twj5CzNCEgizS75iJnUo6G+m
         07DMj3Q551ZZ/vv9TfjK0nimPAsttXIe9M6FlM2nfWlCg0/7X8LXgs/dJ3Z/wHPd6zm7
         PqRQ==
X-Gm-Message-State: APjAAAW2VLJytVToAECSRaEglrHCXB9ysLGYZYTTwuAQ0ke2bv6GijpK
        UdKbnepsJZTwViS0LdSglCoXhRBQBPFibNR1EUkqnnTikFhAVf0jjrj8LSz4vIqE8+uXvgPu1rC
        7W+1m+44aqJ80Tlz/arIxMQ3u47IuPpQwsYjtJMX7uQ==
X-Received: by 2002:aa7:8c42:: with SMTP id e2mr3505338pfd.181.1552648110618;
        Fri, 15 Mar 2019 04:08:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzQ66NUIVD+AWSNT3YnwuEex0GPaho4IklESDY6i7b9UxrOHsrGKbbF+VKFb20yBAPKa7dpNw==
X-Received: by 2002:aa7:8c42:: with SMTP id e2mr3505303pfd.181.1552648110279;
        Fri, 15 Mar 2019 04:08:30 -0700 (PDT)
Received: from 2001-b011-380f-14b9-3cb9-595b-8731-d21f.dynamic-ip6.hinet.net (2001-b011-380f-14b9-3cb9-595b-8731-d21f.dynamic-ip6.hinet.net. [2001:b011:380f:14b9:3cb9:595b:8731:d21f])
        by smtp.gmail.com with ESMTPSA id 3sm2361316pfp.115.2019.03.15.04.08.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 04:08:28 -0700 (PDT)
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Content-Transfer-Encoding: 8bit
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Opportunistic S0ix blocked by e1000e when ethernet is in use
Message-Id: <074E1145-A512-4835-9A6D-8FB6634DBD3C@canonical.com>
Date:   Fri, 15 Mar 2019 19:08:25 +0800
Cc:     "Wang, Yumi" <yumi.wang@intel.com>,
        intel-wired-lan@lists.osuosl.org,
        linux-kernel <linux-kernel@vger.kernel.org>
To:     jeffrey.t.kirsher@intel.com
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeffrey,

There are several platforms that uses e1000e can’t enter Opportunistic S0ix  
(PC10) when the ethernet has a link partner.

This behavior also exits in out-of-tree e1000e driver 3.4.2.1, but seems  
like 3.4.2.3 fixes the issue.

A quick diff between the two versions shows that this code section may be  
our solution:

         /* Read from EXTCNF_CTRL in e1000_acquire_swflag_ich8lan function
          * may occur during global reset and cause system hang.
          * Configuration space access creates the needed delay.
          * Write to E1000_STRAP RO register E1000_PCI_VENDOR_ID_REGISTER value
          * insures configuration space read is done before global reset.
          */
         pci_read_config_word(hw->adapter->pdev, E1000_PCI_VENDOR_ID_REGISTER,
                              &pci_cfg);
         ew32(STRAP, pci_cfg);
         e_dbg("Issuing a global reset to ich8lan\n");
         ew32(CTRL, (ctrl | E1000_CTRL_RST));
         /* cannot issue a flush here because it hangs the hardware */
         msleep(20);

         /* Configuration space access improve HW level time sync mechanism.
          * Write to E1000_STRAP RO register E1000_PCI_VENDOR_ID_REGISTER
          * value to insure configuration space read is done
          * before any access to mac register.
          */
         pci_read_config_word(hw->adapter->pdev, E1000_PCI_VENDOR_ID_REGISTER,
                              &pci_cfg);
         ew32(STRAP, pci_cfg);

Is there any plan to support this in the upstream kernel?

Kai-Heng
