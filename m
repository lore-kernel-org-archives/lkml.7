Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D66C5DF64
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 11:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D1A206A3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 11:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="Wln6GCVy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731446AbfKFLYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 06:24:04 -0500
Received: from canardo.mork.no ([148.122.252.1]:54583 "EHLO canardo.mork.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfKFLYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 06:24:04 -0500
Received: from miraculix.mork.no ([IPv6:2a02:2121:340:755f:c09a:74ff:fe7f:b715])
        (authenticated bits=0)
        by canardo.mork.no (8.15.2/8.15.2) with ESMTPSA id xA6BNVj8026517
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 6 Nov 2019 12:23:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1573039412; bh=v3Ba2yCnHfZ6sWycbEkeGJ9xcXrxQTVKv4WO5jG2qwc=;
        h=From:To:Cc:Subject:References:Date:Message-ID:From;
        b=Wln6GCVyIkaef7sMAOv6ek7lP5o1xy0S1INtPHQnAoDUffuDZ2o0pPydAUfne/laa
         ctt3go12cGkgv/kwJEghK4+6Y1OMP5f4eLb8q3xIdMJi3okndPjaJaw+kiFAQF2MG2
         IjfTIXRXX1PJQ4nncvXP5p0i0jOr5FifEL7Ps8f8=
Received: from bjorn by miraculix.mork.no with local (Exim 4.92)
        (envelope-from <bjorn@mork.no>)
        id 1iSJPI-0005PT-KN; Wed, 06 Nov 2019 12:23:24 +0100
From:   =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        gregkh@linuxfoundation.org, <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: Allow USB device to be warm reset in suspended state
Organization: m
References: <Pine.LNX.4.44L0.1911051200570.1678-100000@iolanthe.rowland.org>
Date:   Wed, 06 Nov 2019 12:23:24 +0100
In-Reply-To: <Pine.LNX.4.44L0.1911051200570.1678-100000@iolanthe.rowland.org>
        (Alan Stern's message of "Tue, 5 Nov 2019 13:07:34 -0500 (EST)")
Message-ID: <87o8xpz1sj.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.101.4 at canardo
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> writes:

> I was sure I remembered reading somewhere that suspended devices were
> not allowed to be reset, but now I can't find that requirement anywhere
> in the USB spec.

I don't know anything about this, but "Reset From Suspended State" is
part of Appendix C in the USB 2.0 spec. Looks valid to me..

Quoting the relevant section for those who don't have that spec at hand:


  C.2.1 Reset From Suspended State

  As can be seen from Figure C-2, the device wakes up from the Suspended
  state as soon as it sees a K or an SE0 on the bus. A J would be
  indistinguishable from idle on the bus that a suspended device sees
  normally. On seeing a K, the device will initiate a resume
  process. For the details of this process, see Section 7.1.7.7. On
  seeing an SE0, the device could enter the reset handshake procedure,
  so it starts timer T0.

  The actual reset handshake is only started after seeing a continuous
  assertion of SE0 for at least 2.5 =CE=BCs (T FILTSE0 ).  The loop between
  the blocks with =E2=80=9CClear timer T1=E2=80=9D and =E2=80=9CRun timer T=
1=E2=80=9D represents this
  filtering. If the device has not detected a continuous SE0 before
  timer T0 exceeds the value of T UCHEND - T UCH , the device goes back
  into the Suspended state.

  A device coming from suspend most probably had its high-speed clock
  stopped to meet the power requirements for a suspended device (see
  Section 7.2.3). Therefore, it may take some time to let the clock
  settle to a level of operation where it is able to perform the reset
  detection and handshake with enough precision. In the state diagram, a
  time symbol T WTCLK is used to have the device wait for a stable
  clock. This symbol is not part of the USB 2.0 specification and does
  not appear in Chapter 7. It is an implementation specific detail of
  the reset detection state diagram for the upstream facing port, where
  it is marked with a asterisk (*). T WTCLK should have a value
  somewhere between 0 and 5.0 ms. This allows at least 1.0 ms time to
  detect the continuous SE0.

  If the device has seen an SE0 signal on the bus for at least T FILTSE0
  , then it can safely assume to have detected a reset and can start the
  reset handshake.




Bj=C3=B8rn
