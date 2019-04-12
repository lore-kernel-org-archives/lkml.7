Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F687C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 09:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2435220850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 09:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="biGPr/kP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfDLJHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 05:07:36 -0400
Received: from canardo.mork.no ([148.122.252.1]:57779 "EHLO canardo.mork.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbfDLJHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 05:07:35 -0400
Received: from miraculix.mork.no ([IPv6:2a02:2121:34e:7a0c:4cff:dff:fef6:bcb])
        (authenticated bits=0)
        by canardo.mork.no (8.15.2/8.15.2) with ESMTPSA id x3C97BBh029095
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 12 Apr 2019 11:07:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1555060032; bh=Aqt+Zy+54vGpk9JTzs/ndlybH3eDHAaKTptJ5oZ/5BU=;
        h=From:To:Cc:Subject:References:Date:Message-ID:From;
        b=biGPr/kPGcVOYLvMB/lRS7JdcAdkhf6qVCMgfABSuDc8eh95KlDlzC4knzVmPUsAM
         kPT//yYcduxu9pbIhb/ljW50NMKf6bzJ9mNqmQEL20cTygUrPjBDG7gh43DQSX3qp3
         9sk2Nyum2qixyPtkboqRUOUFfrO6AkC/qJlgBWsE=
Received: from bjorn by miraculix.mork.no with local (Exim 4.89)
        (envelope-from <bjorn@mork.no>)
        id 1hEs9J-0005FO-Rb; Fri, 12 Apr 2019 11:07:05 +0200
From:   =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To:     Yang Xiao <92siuyang@gmail.com>
Cc:     kbuild-all@01.org, linux-usb@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        greg@kroah.com, mchehab@kernel.org,
        Kees Cook <keescook@chromium.org>, hans.verkuil@cisco.com,
        Young Xiao <YangX92@hotmail.com>
Subject: Re: [PATCH] USB: s2255 & stkwebcam: fix oops with malicious USB descriptors
Organization: m
References: <1555036767-31170-1-git-send-email-92siuyang@gmail.com>
        <878swf645i.fsf@miraculix.mork.no>
        <CAKgHYH05R2CQ1XmS-KCTtL0J49D2kpnkBgyYxdPc47SNpaf8vA@mail.gmail.com>
Date:   Fri, 12 Apr 2019 11:07:05 +0200
In-Reply-To: <CAKgHYH05R2CQ1XmS-KCTtL0J49D2kpnkBgyYxdPc47SNpaf8vA@mail.gmail.com>
        (Yang Xiao's message of "Fri, 12 Apr 2019 16:45:52 +0800")
Message-ID: <87mukv4mo6.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.100.3 at canardo
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yang Xiao <92siuyang@gmail.com> writes:

> If given malicious descritors that spcify 0 for the number of endpoints,
> then there is a null pointer deference when calling function
> usb_endpoint_is_bulk_in.
>
>        for (i =3D 0; i < iface_desc->desc.bNumEndpoints; ++i) {

Try this:

#include <stdio.h>
int main()
{
        int i;
        for (i=3D0; i<0; ++i)
                printf("%d\n");
        return 0;
}

How many lines did it print?


Bj=C3=B8rn
