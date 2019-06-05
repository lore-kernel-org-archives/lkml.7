Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CED7C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 22:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 376DB206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 22:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfFEWGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 18:06:33 -0400
Received: from gate.crashing.org ([63.228.1.57]:33861 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbfFEWGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 18:06:32 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x55M65x2023978;
        Wed, 5 Jun 2019 17:06:06 -0500
Message-ID: <54df139cc6cfef9202be6b945c968c3040591607.camel@kernel.crashing.org>
Subject: Re: [PATCH v2 2/2] irqchip: al-fic: Introduce Amazon's Annapurna
 Labs Fabric Interrupt Controller Driver
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        "Shenhar, Talel" <talel@amazon.com>, nicolas.ferre@microchip.com,
        jason@lakedaemon.net, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, robh+dt@kernel.org,
        davem@davemloft.net, shawn.lin@rock-chips.com, tglx@linutronix.de,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     dwmw@amazon.co.uk, jonnyc@amazon.com, hhhawa@amazon.com,
        ronenk@amazon.com, hanochu@amazon.com, barakw@amazon.com
Date:   Thu, 06 Jun 2019 08:06:05 +1000
In-Reply-To: <0915892c-0e53-8f53-e858-b1c3298a4d35@arm.com>
References: <1559731921-14023-1-git-send-email-talel@amazon.com>
         <1559731921-14023-3-git-send-email-talel@amazon.com>
         <fa6e5a95-d9dd-19f6-43e3-3046e0898bda@arm.com>
         <553d06a4-a6b6-816f-b110-6ef7f300dde4@amazon.com>
         <0915892c-0e53-8f53-e858-b1c3298a4d35@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-06-05 at 16:12 +0100, Marc Zyngier wrote:
> > Those error messages are control path messages. if we return the same 
> > error value from here and from the previous error, how can we 
> > differentiate between the two error cases by looking at the log?
> > 
> > Having informative printouts seems like a good idea for bad 
> > configuration cases as such, wouldn't you agree?
> 
> I completely disagree. The kernel log isn't a dumping ground for this
> kind of pretty useless information. Furthermore, the irq subsystem will
> also shout at you when it gets an error, so no need to add insult to injury.
> 
> If you really want to keep them around, turn them into pr_debug.

I disagree Marc. This is a rather bad error which indicates that the device-tree
is probably incorrect (or the HW was wired in a way that cannot work).

Basically a given FIC can either be entirely level sensitive or entirely edge
sensitive. This catches cases where the DT has routed a mixed of both to the
same FIC. Definitely worth barfing loudly about rather than trying to understand
subtle odd misbehaviours of the device in the field.

Cheers,
Ben.


