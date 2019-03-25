Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023C1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB0720863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbfCYQiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:38:11 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:42129 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbfCYQiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:38:11 -0400
Received: by mail-ed1-f46.google.com with SMTP id x61so2460981edc.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 09:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y2QQuyj2D0AzWsTTJNpnLygBk/tFYTrXnMTJLJmSSNs=;
        b=IyqoQQAUV2abgv7RlibS7a15/72TiAaDrwvM58+/dhMSgniFhPFGi8LpH+XohUDKqG
         KN9giVTBwr0nGKq3+yHpNrE2oSN5Sa/BjwEGdpVn7mRf3wh+iMTMoEfDdjZ6lhthE5bX
         tHqsNfo/wQkOXZY/YVhrGMbeGAnqcLyRH3esVlVY7KpPwrB2cP6TdhkLF1NCjSrO0N3g
         yDX0tKZ7v4Lybyj8365zKcV0zjZhzC/588K5iCzkEQ0DS4p32bd5MBRW3TB+vXwtmHIe
         3WeKYzFq42SyTKRQn/L8ee6ja+PbIaSSWk2BRzsIRmiH3S26OoWvo0baRCciFk3Ja1S4
         Q4TA==
X-Gm-Message-State: APjAAAWRTxWPNa6cPx0WsNPPUvp6Y6N4Xou8KZJ9r/MBbuvKlbyzuQX2
        gqhfbftvzCzzuLO0xl0BANiMFQ==
X-Google-Smtp-Source: APXvYqxxpDbN4wUO/Yb6F0bAMNNEMgb4HZUS1MSDIjPB7f8UCBLwhWul2CTu9Ihz2yicS10wBpJTJQ==
X-Received: by 2002:a17:906:b34c:: with SMTP id cd12mr14547814ejb.106.1553531889556;
        Mon, 25 Mar 2019 09:38:09 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id g7sm5749732edl.51.2019.03.25.09.38.08
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 09:38:08 -0700 (PDT)
Subject: Re: [PATCH] ELAN touchpad i2c_hid bugs fix
To:     Dmitry Torokhov <dtor@chromium.org>,
        Vladislav Dalechyn <vlad.dalechin@gmail.com>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, kai.heng.feng@canonical.com,
        swboyd@chromium.org, bigeasy@linutronix.de,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, hotwater438@tutanota.com
References: <20190325125704.6585-1-hotwater438@tutanota.com>
 <CAE_wzQ8Aep1FOONeCUxvjBFbgKcVRWP5mUuwQnDxzfemUw-eaA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a2952bc4-0ad0-c8a0-5a5b-13a279023455@redhat.com>
Date:   Mon, 25 Mar 2019 17:38:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <CAE_wzQ8Aep1FOONeCUxvjBFbgKcVRWP5mUuwQnDxzfemUw-eaA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On 25-03-19 17:02, Dmitry Torokhov wrote:
> Hi Vladislav,
> 
> On Mon, Mar 25, 2019 at 5:57 AM Vladislav Dalechyn
> <vlad.dalechin@gmail.com> wrote:
>>
>> From: Vladislav Dalechyn <hotwater438@tutanota.com>
>>
>> Description: The ELAN1200:04F3:303E touchpad exposes several issues, all
>> caused by an error setting the correct IRQ_TRIGGER flag:
>> - i2c_hid incoplete error flood in journalctl;
>> - Five finger tap kill's module so you have to restart it;
>> - Two finger scoll is working incorrect and sometimes even when you
>> raised one of two finger still thinks that you are scrolling.
>>
>> Fix all of these with a new quirk that corrects the trigger flag
>> announced by the ACPI tables. (edge-falling).
> 
> I do not believe this is right solution. The driver makes liberal use
> of disable_irq() and enable_irq() which may lead to lost edges and
> touchpad stopping working altogether.
> 
> Usually the "extra" report is caused by GPIO controller clearing
> interrupt condition at the wrong time (too early), or in unsafe or
> racy fashion. You need to look there instead of adding quirk to
> i2c-hid.

The falling-edge solution was proposed by Elan themselves.

Also if you look at: https://bugzilla.redhat.com/show_bug.cgi?id=1543769

And esp. the "cat /proc/interrupts" output there, then you will see
that the interrupt seems to be stuck at low level, which according
to the ACPI tables is its active level.

As for this being a GPIO chip driver problem, this is using standard
Intel pinctrl stuff, which is not showing this same issue with many
other i2c-hid touchpads.

Regards,

Hans

