Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C570DC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 18:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94CA0206BF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 18:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Jiw/RLfu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfEGSxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 14:53:17 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:56418 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726464AbfEGSxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 14:53:17 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A6E6AC01D6;
        Tue,  7 May 2019 18:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1557255190; bh=/bJFOGwRieHqxEusettdT/vBPglvJRx+y/MLRwTz3z8=;
        h=From:To:CC:Subject:Date:References:From;
        b=Jiw/RLfu/a1ikO29cRvv/45GwgPj5oMh3IWjlQKvhGJ9QNo4VVwckP5PPx6SZ7cla
         lVC7UZCavTOkDn5wUPEFTlPG3OksdhEdWm6Cfzjyp3DfJQ8irqtmvUxVI/1cPixwRl
         o68c0x1GAxuHb0DjIMru83atf19Un2Kq1tXn0N/2NaQNNRxYlno63CsiqtDTT3W/Pf
         uCrVw0/VHZOyPHRBpYIbdOuWeBTJP8gUoOw1NzlzrO5q3IG3WUwxMYdis7XSMWhJGl
         qNd8sKVQjpPAgU/bcRNEipjtp11r3RUOlHSCNfYVD7b80M0kXhNR501x7l8WYb7dWZ
         xowRUPQ9H+F2A==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id CC435A0084;
        Tue,  7 May 2019 18:53:15 +0000 (UTC)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.223]) by
 US01WXQAHTC1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Tue,
 7 May 2019 11:53:15 -0700
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     "Claus H. Stovgaard" <cst@phaseone.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: Re: [PATCH] usb: gadget: configfs: Add lpm_Ux_disable
Thread-Topic: [PATCH] usb: gadget: configfs: Add lpm_Ux_disable
Thread-Index: AQHVBLXbiuLSRZBxxUeout6SXcNukg==
Date:   Tue, 7 May 2019 18:53:15 +0000
Message-ID: <30102591E157244384E984126FC3CB4F639E9057@us01wembx1.internal.synopsys.com>
References: <1557220655-123090-1-git-send-email-cst@phaseone.com>
 <1557221830.114189.8.camel@phaseone.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.13.184.19]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claus,=0A=
=0A=
Claus H. Stovgaard wrote:=0A=
> On Tue, 2019-05-07 at 11:09 +0200, Claus H. Stovgaard wrote:=0A=
>> When combining dwc3 with an redriver for a USB Type-C device=0A=
>> solution, it=0A=
>> sometimes have problems with leaving U1/U2 for certain hosts,=0A=
>> resulting in=0A=
>> link training errors and reconnects. This create an interface via=0A=
>> configfs for disabling U1/U2, enabling a workaround for devices based=0A=
>> on=0A=
>> dwc3.=0A=
>>=0A=
> Sorry messed up a bit with a missing cover letter.=0A=
> This feature relates to Anurag patch [1] and a thread [2] from earlier =
=0A=
>=0A=
> Where Anurags patch focus on setting U1/U2 latency in the BOS=0A=
> descriptor from the devicetree, this patch focuses on having a configfs=
=0A=
> interface for forcing the UDC (here the dwc3) to not enable U1/U2 and=0A=
> reject the SET_SEL(U1/U2).=0A=
>=0A=
> Looking forward to input.=0A=
>=0A=
> [1] https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__www.spinics.ne=
t_lists_linux-2Dusb_msg179732.html&d=3DDwIDaQ&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=
=3Du9FYoxKtyhjrGFcyixFYqTjw1ZX0VsG2d8FCmzkTY-w&m=3DwKdyWmYpbW791LAm7rYwvFYx=
5E0bjENyXZzHvK4vyFo&s=3Des7kki6iuLJUp2rJnzP9alXKyfJPNSfyxTVCKKDd_rQ&e=3D=0A=
> [2] https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__www.spinics.ne=
t_lists_linux-2Dusb_msg179393.html&d=3DDwIDaQ&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=
=3Du9FYoxKtyhjrGFcyixFYqTjw1ZX0VsG2d8FCmzkTY-w&m=3DwKdyWmYpbW791LAm7rYwvFYx=
5E0bjENyXZzHvK4vyFo&s=3DcFTmO9wPf7b6TZxFUAAIJM0Z_wM1ttNIc1rct0uR6co&e=3D=0A=
>=0A=
>=0A=
=0A=
I'm not sure who will submit the patch to make change to DWC3 for=0A=
disabling U1/U2 (Anurag or you), but can you split your patch between=0A=
dwc3 and configfs.=0A=
=0A=
Thanks,=0A=
Thinh=0A=
