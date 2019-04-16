Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7E6C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A1F21900
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbfDPNy7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:54:59 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:54081 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfDPNy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:54:58 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 6B3FA3C00C1;
        Tue, 16 Apr 2019 15:54:55 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Xq_FnHzAvfbJ; Tue, 16 Apr 2019 15:54:48 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 58EFA3C00C0;
        Tue, 16 Apr 2019 15:54:48 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com ([fe80::69bf:8148:2f13:f289]) by
 HI2EXCH01.adit-jv.com ([fe80::69bf:8148:2f13:f289%12]) with mapi id
 14.03.0439.000; Tue, 16 Apr 2019 15:54:48 +0200
From:   "Rodin, Michael (Ferchau; ADITG/ESM1)" <mrodin@de.adit-jv.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
CC:     "Friedrich, Eugen (ADITG/ESM1)" <efriedrich@de.adit-jv.com>,
        "Rosca, Eugeniu (ADITG/ESM1)" <erosca@de.adit-jv.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Questions regarding Documentation/media/uapi/v4l/field-order.rst
Thread-Topic: Questions regarding
 Documentation/media/uapi/v4l/field-order.rst
Thread-Index: AdT0SL9o51JIskG9TEewiVl3rOlV0g==
Date:   Tue, 16 Apr 2019 13:54:46 +0000
Message-ID: <AC35D0CFBC66A84AAA9DF4334B52828D13614162@HI2EXCH01.adit-jv.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.72.92.112]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I would like to ask several questions regarding the documentation of the enum "v4l2_field" [1].
These questions came up during my investigations of issues with interaction between
the gstreamer plugin v4l2src and the rcar video input driver [2].

The documentation [1] specifies that:
"All video capture and output devices must report the current field order.
Some drivers may permit the selection of a different order, to this end
applications initialize the field field of struct v4l2_pix_format before
calling the VIDIOC_S_FMT ioctl. If this is not desired it should have
the value V4L2_FIELD_ANY (0)."

If I have understood these lines correctly, this means that if userspace sets "field" member of
the struct "v4l2_pix_format" to V4L2_FIELD_ANY and uses this as parameter for the VIDIOC_S_FMT ioctl,
then a driver should select/report the field order, which was previously set by media-ctl utility
in the next subdevice, which is connected to the /dev/videoX node
(From my understanding this would be equivalent to the "current field order").

If the described behavior is correct, then the description in the table row for V4L2_FIELD_ANY in [1] is incomplete:
"Applications request this field order when any one of the V4L2_FIELD_NONE, V4L2_FIELD_TOP, V4L2_FIELD_BOTTOM, or V4L2_FIELD_INTERLACED formats is acceptable."
What if V4L2_FIELD_ALTERNATE or V4L2_FIELD_SEQ_TB or V4L2_FIELD_SEQ_BT are also acceptable for the application?
I think that the specification is either unprecise or my understanding of the specification is wrong.

Another potential issue, which I found in this documentation is that it does not distinguish between
multiple contexts in which enum v4l2_field can be used. I can think of at least two different contexts:
- When used to select the field order with VIDIOC_S_FMT ioctl.
- When used to report the field order in a buffer: for example application sets V4L2_FIELD_ALTERNATE in VIDIOC_S_FMT ioctl and then gets buffers, which have V4L2_FIELD_TOP/BOTTOM set.
Now with this in mind, when I read the description of V4L2_FIELD_NONE:
"The driver may also indicate this order when it cannot distinguish between V4L2_FIELD_TOP and V4L2_FIELD_BOTTOM."
I see two possible meanings/interpretations:
- If application sets V4L2_FIELD_ALTERNATE in VIDIOC_S_FMT ioctl, report V4L2_FIELD_NONE back
   so the application knows that the driver can not provide any TOP/BOTTOM metadata in the buffers
   (which may be necessary for the application for example for deinterlacing) before it has got any buffer.
- If application sets V4L2_FIELD_ALTERNATE in VIDIOC_S_FMT ioctl, driver reports V4L2_FIELD_ALTERNATE back,
   even if it can not distinguish between TOP/BOTTOM. But when the application starts to read buffers,
   they have V4L2_FIELD_NONE set if it's not possible to distinguish between TOP/BOTTOM.

Also there is another ambiguity in the description of V4L2_FIELD_NONE:
"Images are in progressive format, not interlaced."
What does "interlaced" mean in this case? Does it mean the other possible enum values or just the V4L2_FIELD_INTERLACED?
If this just means V4L2_FIELD_INTERLACED, then it would imply that for example V4L2_FIELD_SEQ_TB 
and V4L2_FIELD_ALTERNATE are progressive formats, which is obviously not true.
And also generally, in which of described contexts should be V4L2_FIELD_NONE set or reported (buffer or VIDIOC_S_FMT ioctl)?
Another point is that V4L2_FIELD_INTERLACED is also used by v4l2src to tell rcar-vin driver to combine the fields before giving them to application,
so basically it requests progressive signal. So the meanings of V4L2_FIELD_INTERLACED and V4L2_FIELD_NONE are basically the same in this case.

Thank you in advance and sorry for the long mail!

[1] Documentation/media/uapi/v4l/field-order.rst
[2] drivers/media/platform/rcar-vin

Best regards

Michael Rodin

Advanced Driver Information Technology GmbH
Engineering Software Multimedia 1 (ADITG/ESM1)
Robert-Bosch-Str. 200
31139 Hildesheim
Germany

Tel. +49 5121 49 6936
Fax +49 5121 49 6999
mrodin@de.adit-jv.com
Web: www.adit-jv.com

ADIT is a joint venture company of Robert Bosch GmbH/Robert Bosch Car Multimedia GmbH and DENSO Corporation
Sitz: Hildesheim, Registergericht: Amtsgericht Hildesheim HRB 3438
Geschaeftsfuehrung: Wilhelm Grabow, Ken Yaguchi
