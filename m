Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B39DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 09:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032422082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 09:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551693537;
	bh=Yejz3ytLeqLjS1isL19coWc6IktJ4wQ8V6uqgPIf8YM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tBIQy0tm8EzWOdJry4rt7ohlwl+bGPvbvkoWS0FIgdfVq0A3/0d/v0TYwcEA5yrgX
	 OsiWAwZtakA9DEfH4kAhHA0kYeRiHzfJm3LWSM4gbcbDLV0/YrHUMpAtsybalT76+S
	 O3rS1abU3Wkv4CVekh5Zej2Z01B6+ng4nfWKVQX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfCDJ6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 04:58:55 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45523 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfCDJ6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 04:58:55 -0500
Received: by mail-ot1-f66.google.com with SMTP id i12so3717081otp.12;
        Mon, 04 Mar 2019 01:58:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yejz3ytLeqLjS1isL19coWc6IktJ4wQ8V6uqgPIf8YM=;
        b=TIR8Ari5m6d0GpOWXnWXdIpA0yf8jbX07886l6UIwPepA9b0Ovte3cAIUZEixR12Np
         3v1iYVz+K/WIDNs+MPFmCxqf1/ygeDAgwB8tEoUVPPqxFiKdBasSCDFeYXWoGR5Lif53
         P7fKIDT2R6VbW/cbF5FLFBJv9v3dvbVmO/S4g+0JlGZcICgbkHZEhQAGGZ4or4MpnONB
         fwkNUMl8A1mCJO0x07i+3X+cc18+nRvJEvIBmsgqDUGVi7sP60uM41qTXZGriOe7FivZ
         beO5+HVfb43GlKLLfWhSU4SP3R6TvcU7fSalzvf82ZW4yMrgyX82OT9WzIAJK+A2wATe
         zWAA==
X-Gm-Message-State: APjAAAV1Y8UdUTBktZInaQ0F++uUonuT1+JeJoh0PQI0xoTE/uFtt61a
        4agMLloTJ97L3Rz/Hl/eGsE0NELb587UCxEidkY=
X-Google-Smtp-Source: APXvYqybZ3SR8qPIGSFCpq8eNQKd4JnsAYOtPFEexj/CkxwW6eyyf0mFHaqINMZ3r93ITe9MBAfoPOEWtRCtLlIDjDI=
X-Received: by 2002:a9d:718d:: with SMTP id o13mr11515137otj.119.1551693534320;
 Mon, 04 Mar 2019 01:58:54 -0800 (PST)
MIME-Version: 1.0
References: <9956076.F4luUDm1Dq@aspire.rjw.lan> <CABFtUbT6gRQETzZqR7QY6WYDKzF2ZVZ-Y2XQ-bOZnrmBZSnPvQ@mail.gmail.com>
In-Reply-To: <CABFtUbT6gRQETzZqR7QY6WYDKzF2ZVZ-Y2XQ-bOZnrmBZSnPvQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 4 Mar 2019 10:58:42 +0100
Message-ID: <CAJZ5v0hoNK5ez8ZqKzuFmBvXwpnB_rKUteRdE31ALWAVUhaKbw@mail.gmail.com>
Subject: Re: [RFT][PATCH 0/2] cpufreq: intel_pstate: Handle _PPC updates on
 global turbo disable/enable
To:     Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 3, 2019 at 11:42 PM Gabriele Mazzotta
<gabriele.mzt@gmail.com> wrote:
>
> Hi,
>
> I applied these patches on top of 4.20. The max frequency of all the
> cores now reflects the actual value and it's updated whenever I
> change the power source.

Thanks for the confirmation!
