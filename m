Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09042C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB9B1208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbfFXKAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:00:34 -0400
Received: from goliath.siemens.de ([192.35.17.28]:33266 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbfFXKAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:00:31 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id x5OA03Fp014621
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 12:00:03 +0200
Received: from [167.87.13.35] ([167.87.13.35])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id x5OA01AA023870;
        Mon, 24 Jun 2019 12:00:02 +0200
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Subject: x86: Spurious vectors not handled robustly
Message-ID: <e525108f-3749-4e1d-1ac2-0d0a2655f15f@siemens.com>
Date:   Mon, 24 Jun 2019 12:00:00 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

probably since "x86: Avoid building unused IRQ entry stubs" (2414e021ac8d), the 
kernel can no longer tell spurious IRQs by the APIC apart from spuriously 
triggered unused vectors. We've managed to trigger such a cause with the 
Jailhouse hypervisor (incorrectly injected MANAGED_IRQ_SHUTDOWN_VECTOR), and the 
result was not only a misreport of the vector number (0xff instead of 0xef - 
took me a while...), but also stalled interrupts of equal and lower priority 
because a spurious interrupt is not (and must not be) acknowledged.

How to address that best? I would say we should at least have separate entry 
paths for APIC interrupt vs. vectors, to improve robustness in the faulty case.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
