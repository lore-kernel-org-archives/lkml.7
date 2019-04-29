Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13908C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 21:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F1321783
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 21:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="mnd8XLDi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbfD2VsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 17:48:09 -0400
Received: from mail.nic.cz ([217.31.204.67]:53218 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729536AbfD2Vry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 17:47:54 -0400
Received: from localhost (unknown [172.20.6.125])
        by mail.nic.cz (Postfix) with ESMTPS id E4E39634BF;
        Mon, 29 Apr 2019 23:47:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1556574472; bh=LD8SQDhAqyKmvTtEPATVRg7ybOJWGlffbG6DNxjdBTM=;
        h=Date:From:To;
        b=mnd8XLDiXaUs1gAX3GjkBBaOmbmY4L7OcgZS/F9R5n6bY1nRqr5Ekev+sA8t2mcJS
         jT9WOYwO6vN4bV9Kpu8HoNNOr5U76dtCG+U7Cf+LeCjZjdnK2evyXl9VHlhVvcfUKw
         u7hFsb6bbG78GjjKVjX6tJ2o/J9CTp82bBIHCojk=
Date:   Mon, 29 Apr 2019 23:47:52 +0200
From:   Marek Behun <marek.behun@nic.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Subject: sysfs attrs for HW ECDSA signature
Message-ID: <20190429234752.171b4f2b@nic.cz>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg and Tejun,

is it acceptable for a driver to expose sysfs attr files for ECDSA
signature generation?

The thing is that
  1. AFAIK there isn't another API for userspace to do this.
     There were attempts in 2015 to expose akcipher via netlink to
     userspace, but the patchseries were not accepted.
  2. even if it was possible, that specific device for which I am
     writing this driver does not provide the ability to set the
     private key to sign with - the private key is just burned during
     manufacturing and cannot be read, only signed with.

The current version of my driver exposes do_sign file in
/sys/firmware/turris_mox directory.

Userspace should write message to sign and then can read the signature
from this do_sign file.

According to the one attr = one file principle, it would be better to
have two files: ecdsa_msg_to_sign (write-only) and ecdsa_signature
(read-only).
Would this be acceptable in the kernel for this driver?

I have also another question, if you would not mind:

This driver is dependant on a mailbox driver I have also written
("mailbox: Add support for Armada 37xx rWTM mailbox"), but I have not
received any review for this driver from the mailbox subsystem
maintainer, and I have already sent three versions (on 12/17/2018,
03/01/2019 and 03/15/2019).
What should I do in this case?

Thank you.

Marek
