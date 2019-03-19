Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2EDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC1F2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="dL8Ar8Mh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfCSO77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:59:59 -0400
Received: from canardo.mork.no ([148.122.252.1]:33931 "EHLO canardo.mork.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbfCSO77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:59:59 -0400
Received: from miraculix.mork.no ([IPv6:2a02:2121:288:b97:1c73:e9ff:fe7f:e01b])
        (authenticated bits=0)
        by canardo.mork.no (8.15.2/8.15.2) with ESMTPSA id x2JExgZg030715
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 19 Mar 2019 15:59:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1553007583; bh=NLo3Eqvh+LuCiP8bfsSoNSwQV9/09fbjfZEBj1mKbSo=;
        h=From:To:Cc:Subject:References:Date:Message-ID:From;
        b=dL8Ar8Mh1IC66ZsTvSDqmk3dcVZ0JGgm5yMAxzEJrR5voTUU4YuPs+mj3IRy2ycP/
         S+0F2MCRgW6sJOLhVtPH7jv1rDanl2NSm6NRzbs5NE48NAJ6/qx4OMsHiZXvC/0hdq
         3pfp98AMCNdBXnSJxnffH/UYga7joHbcNveUhUqg=
Received: from bjorn by miraculix.mork.no with local (Exim 4.89)
        (envelope-from <bjorn@mork.no>)
        id 1h6GDI-00022w-O3; Tue, 19 Mar 2019 15:59:36 +0100
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
        <yw1xr2b3ylsp.fsf@mansr.com>
Date:   Tue, 19 Mar 2019 15:59:36 +0100
In-Reply-To: <yw1xr2b3ylsp.fsf@mansr.com> (=?utf-8?Q?=22M=C3=A5ns_Rullg?=
 =?utf-8?Q?=C3=A5rd=22's?= message of "Tue,
        19 Mar 2019 14:35:18 +0000")
Message-ID: <878sxa9ag7.fsf@miraculix.mork.no>
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
> Dan Williams <dcbw@redhat.com> writes:
>
>> TLDR; some firmware uses the DTR signal as an indicator to come out of
>> low-power mode. Without doing so you cannot talk to the modem over any
>> of it's ports, QMI, net, or serial.
>
> I must be missing something, but how does a network interface have a DTR
> signal?

It does not.  But the network function is (ab)using the Comm class USB
control message "SetControlLineState" to signal "wake up" from the host
to the device.  Which is perfectly fine since the USB function in
question is vendor specific.  The vendor can define any USB control
message to mean anything they want. Reusing a Comm class message
probably made sense to the firmware engineer designing this.  We can
only note and adapt.

It doesn't have anything to do with DTR.


Bj=C3=B8rn
