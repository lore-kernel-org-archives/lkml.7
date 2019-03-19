Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D28CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A2B20863
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="SuwF7J6M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfCSRPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:15:47 -0400
Received: from canardo.mork.no ([148.122.252.1]:38623 "EHLO canardo.mork.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbfCSRPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 13:15:47 -0400
Received: from miraculix.mork.no (miraculix.mork.no [IPv6:2001:4641:0:2:7627:374e:db74:e353])
        (authenticated bits=0)
        by canardo.mork.no (8.15.2/8.15.2) with ESMTPSA id x2JHFZpI016403
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 19 Mar 2019 18:15:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1553015735; bh=H06E65+uwfvBFSExCJWalew4YKXcmLvx2l2JcOPU5dQ=;
        h=From:To:Cc:Subject:References:Date:Message-ID:From;
        b=SuwF7J6MuULRmsm6gNLThKmVAAgm9sl33M1rCRf/z2VcLtwCq28Z3cDRR0iDQHGw8
         bAMeiX4lOok5KUoisaDFYH7iCUAWtPHcyjA7p++tf04uI/zwQPFNlqOanL1ryLG7cQ
         3FbLavGGndGgF0F/I+WlCMBwpPxPXkJJaFFPvv4k=
Received: from bjorn by miraculix.mork.no with local (Exim 4.89)
        (envelope-from <bjorn@mork.no>)
        id 1h6IKs-0002TJ-UO; Tue, 19 Mar 2019 18:15:34 +0100
From:   =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To:     =?utf-8?Q?M=C3=A5ns_Rullg=C3=A5rd?= <mans@mansr.com>
Cc:     Dan Williams <dcbw@redhat.com>, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: set driver_info for SIM5218 and compatibles
Organization: m
References: <20190226170710.12709-1-mans@mansr.com>
        <20190227083342.GJ4747@localhost> <yw1xpnrdv3z7.fsf@mansr.com>
        <20190227131315.GO4747@localhost> <yw1xlg21uwrp.fsf@mansr.com>
        <20190319102840.GI6124@localhost> <yw1xd0mn16ev.fsf@mansr.com>
        <20190319110819.GB3178@localhost> <yw1x8sxb125q.fsf@mansr.com>
        <20190319122719.GC3178@localhost> <20190319124358.GK6124@localhost>
        <6c89938b00ad289e1802f675bd00e288b1458d73.camel@redhat.com>
        <yw1xr2b3ylsp.fsf@mansr.com> <878sxa9ag7.fsf@miraculix.mork.no>
        <yw1xmulqzv7k.fsf@mansr.com>
Date:   Tue, 19 Mar 2019 18:15:34 +0100
In-Reply-To: <yw1xmulqzv7k.fsf@mansr.com> (=?utf-8?Q?=22M=C3=A5ns_Rullg?=
 =?utf-8?Q?=C3=A5rd=22's?= message of "Tue,
        19 Mar 2019 16:26:39 +0000")
Message-ID: <87r2b27pl5.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.100.2 at canardo
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

M=C3=A5ns Rullg=C3=A5rd <mans@mansr.com> writes:

> Every time you think USB can't get any worse, it does.

You can't blame vendor creativity on the bus spec.  Look at what the
same vendors do to e.g. SCSI to make these firmwares appear as different
USB devices.  The fact that some of then use "eject" as a signal to
reboot the firmware into some other mode is not a SCSI problem.

But I do agree that USB should have dropped "vendor specific" and
mandated class functions for everything.  In theory. In practice, that
would probably have casued USB to lose to some other competing spec with
vendor specific as an option...



Bj=C3=B8rn
