Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCDBC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 00:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B5920873
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 00:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbfGRAGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 20:06:42 -0400
Received: from egyptian.birch.relay.mailchannels.net ([23.83.209.56]:31915
        "EHLO egyptian.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728049AbfGRAGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 20:06:42 -0400
X-Sender-Id: 18vtm3q735|x-authuser|mail@thomaslambertz.de
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 6030750118A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 23:48:22 +0000 (UTC)
Received: from relay004.mxroute.com (100-96-4-184.trex.outbound.svc.cluster.local [100.96.4.184])
        (Authenticated sender: 18vtm3q735)
        by relay.mailchannels.net (Postfix) with ESMTPA id 16F6B50152F
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 23:48:20 +0000 (UTC)
X-Sender-Id: 18vtm3q735|x-authuser|mail@thomaslambertz.de
Received: from relay004.mxroute.com ([TEMPUNAVAIL]. [185.234.75.11])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.17.3);
        Wed, 17 Jul 2019 23:48:22 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: 18vtm3q735|x-authuser|mail@thomaslambertz.de
X-MailChannels-Auth-Id: 18vtm3q735
X-Belong-Harbor: 7e2961444de4470f_1563407302155_2635510663
X-MC-Loop-Signature: 1563407302155:2693518527
X-MC-Ingress-Time: 1563407302155
Received: from relay-ext1.mxrelay.co (relay-ext1.mxrelay.co [185.19.31.132])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay004.mxroute.com (Postfix) with ESMTPS id 89E083F0E1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 23:48:13 +0000 (UTC)
Received: from qrelay100.mxroute.com (qrelay100.mxroute.com [172.82.139.100])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay-ext1.mxrelay.co (Postfix) with ESMTPS id 9121047389
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 23:48:11 +0000 (UTC)
Received: from filter002.mxroute.com (unknown [94.130.183.33])
        by qrelay100.mxroute.com (Postfix) with ESMTP id DD93F10086D;
        Wed, 17 Jul 2019 19:48:09 -0400 (EDT)
Received: from aus.mxroute.com (unknown [45.125.247.50])
        by filter002.mxroute.com (Postfix) with ESMTPS id 02F3B3F03D;
        Wed, 17 Jul 2019 23:48:04 +0000 (UTC)
From:   Thomas Lambertz <mail@thomaslambertz.de>
Subject: [5.2 regression] x86/fpu changes cause crashes in KVM guest
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Message-ID: <217248af-e980-9cb0-ff0d-9773413b9d38@thomaslambertz.de>
Date:   Thu, 18 Jul 2019 01:47:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AuthUser: mail@thomaslambertz.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since kernel 5.2, I've been experiencing strange issues in my Windows 10 
QEMU/KVM guest.
Via bisection, I have tracked down that the issue lies in the FPU state 
handling changes.
Kernels before 8ff468c29e9a9c3afe9152c10c7b141343270bf3 work great, the 
ones afterwards are affected.
Sometimes the state seems to be restored incorrectly in the guest.

I have managed to reproduce it relatively cleanly, on a linux guest.
(ubuntu-server 18.04, but that should not matter, since it occured on 
windows aswell)

To reproduce the issue, you need prime95 (or mprime), from 
https://www.mersenne.org/download/ .
This is just a stress test for the FPU, which helps reproduce the error 
much quicker.

- Run it in the guest as 'Benchmark Only', and choose the '(2) Small 
FFTs' torture test. Give it the maximum amount of cores (for me 10).
- On the host, run the same test. To keep my pc usable, I limited it to 
5 cores. I do this to put some pressure on the system.
- repeatedly focus and unfocus the qemu window

With this config, errors in the guest usually occur within 30 seconds. 
Without the refocusing, takes ~5min on average, but the variance of this 
time is quite large.

The error messages are either
     "FATAL ERROR: Rounding was ......., expected less than 0.4"
or
     "FATAL ERROR: Resulting sum was ....., expexted: ......",
suggesting that something in the calculation has gone wrong.

On the host, no errors are ever observed!


I am running an AMD Ryzen 5 1600X on an Gigabyte GA-AX370 Gaming 5 
motherboard.
My main operating system is ArchLinux, the issue exists both with the 
Arch and upstream kernel.
QEMU is managed with virt-manager, but the issue also appears with the 
following simple qemu cmdline:

qemu-system-x86_64 -hda /var/lib/libvirt/images/ubuntu18.04.qcow2 
-enable-kvm -smp 10 -m 2048

When kvm acceleration is disabled, the issue predictably goes away.

The issue still exists on the latest github upstream kernel, 
22051d9c4a57d3b4a8b5a7407efc80c71c7bfb16.

- Thomas
