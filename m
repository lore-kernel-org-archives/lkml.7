Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AC3C06510
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 11:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 662ED2089C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 11:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbfGALa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 07:30:29 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44506 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfGALa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 07:30:29 -0400
Received: by mail-ed1-f66.google.com with SMTP id k8so22879630edr.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 04:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4FZVerzE1oFDIf/AEgJefyhsJDoB9qh6VUR1z8DL6tw=;
        b=SrB61me/+0JfOJyEayjPqtq0mAkqcfLd3WCwghSWA19QQVTdkfuH+6opTAqSd7TMdm
         WQxAN1+/cYb5dgo+S5mq6/drev76NpRFS6qGU3p7zsW4xV3n7CkIa1F8W5/L3AlaAvQf
         TEIvMa4LYEyDhnRTEwzaDrNCP4iv4mIbk8h/HxzdAX4EfB4WASEibxcYJ2ibM4TSMxnF
         WZpqzgHY3N2BG9nBKcH19bDxbHRqKAGr0GB9vIyKlh9QvKa+pv9nnvyqDubJRd3Diyz/
         q1gK1ewqGJhwfdFEuOiJ1/jZn/N2qy7tfkm+rfTf1N96m3mHvfBY2P/5Vkqm7tFVY21E
         tkGw==
X-Gm-Message-State: APjAAAUgCb0ZHUirH5w91I8qpfke20Hsk22N4ypcFvSLEyrhTpHvkuTZ
        uKQGXyJmiBLZ6GtcsUv76iW6iA==
X-Google-Smtp-Source: APXvYqz/0QfqYPFurt8vHq2JQ9efiubTG15CmggEQS1oSAuTuLo82LfJbwtMPGobRwI6nNQaLSJ6rw==
X-Received: by 2002:a50:e718:: with SMTP id a24mr28061508edn.91.1561980627445;
        Mon, 01 Jul 2019 04:30:27 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id v32sm3589172edm.92.2019.07.01.04.30.26
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 04:30:26 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] PM: PCI/ACPI: Hibernation handling fixes
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Robert R. Howell" <RHowell@uwyo.edu>
References: <4976412.ihyb9sT5jY@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <fc53d965-c5b6-45b9-8e0d-1de2fbed09a8@redhat.com>
Date:   Mon, 1 Jul 2019 13:30:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <4976412.ihyb9sT5jY@kreacher>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On 01-07-19 12:42, Rafael J. Wysocki wrote:
> Hi All,
> 
> This series of patches addresses a few issues related to the handling of
> hibernation in the PCI bus type and the ACPI PM domain and ACPI LPSS driver.
> 
> The v2 addresses Hans' concerns regarding the LPSS changes.
> 
> First of all, all of the runtime-suspended PCI devices and devices in the ACPI PM and LPSS
> PM domains will be resumed during hibernation (first patch).  This appears to be the
> only way to avoid weird corner cases and the benefit from avoiding to resume those
> devices during hibernation is questionable.
> 
> That change allows the the hibernation callbacks in all of the involved subsystems to be
> simplified (patches 2 and 3).
> 
> Moreover, reusing bus-level suspend callbacks for the "poweroff" transition during
> hibernation (which is the case for the ACPI PM domain and LPSS) is incorrect, so patch 4
> fixes that.
> 
> Finally, there are some leftover items in linux/acpi.h that can be dropped (patch 5).

Thank you for the new version, the entire series looks good to me now:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

p.s.

FWIW I agree that the calling of the suspend_late method of the i2c-designware driver
at suspend_noirq time is ugly, thank you for adding the comment documenting this.
