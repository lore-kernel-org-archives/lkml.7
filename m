Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFB9C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 09:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2552F2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 09:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRMMerL3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfDLJAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 05:00:06 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:45302 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfDLJAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 05:00:05 -0400
Received: by mail-vk1-f193.google.com with SMTP id h127so1986544vkd.12;
        Fri, 12 Apr 2019 02:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bSAd7U8tlK1c5XINJDLZed1vj3w8V08daB+Zbu7d/CE=;
        b=hRMMerL3cgx7Ik30Jv+mtFY8mnbaj/qQ6BQYR4Rz6NVfla/IE7YjlS+VI4JIB2d03Y
         uvhO99xJENymVFtEtb1nXdKThIrHcqhdJZo8OyZ4UhODosX8kr4ojLu5s5KjDPaiAYL7
         cgDHI9ylN8z8wkM1WDASl6Eh8yMVzU2FD04AXY9xbn+UmigxMXeA1rNualvnmKGLgHE3
         FwN9SvxBdUhBgXsFFI6yPqtD+W5wAdQA3qwCF4JIM74N6abYOnuJ6Tn8Psa9yEZ5914J
         dXU6KNER24hWV7NICP0AIdW1RyY2+RFcXAW9U4JcT5PeZX5UiUdd1QHqgEZ1vcEJFS0u
         cAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bSAd7U8tlK1c5XINJDLZed1vj3w8V08daB+Zbu7d/CE=;
        b=tyNpzg+9QYF9cmD11EVsTujHL0UYLZ0cZT7+SDkDkTZyNIHglB6ZRTftwEOGHozOcf
         z021V1Pvg26lzX1Xo1J/FSDyWVCVXrT0y8lEV8XIbjj9pswmD0dr/JdK4PBQPtOAmWOk
         aXdirQR8LPYsshASlTxtJdWVEL8rklK4GFh2y6hqsGCSLt3luwb9sqeuJzyoTDDKNuAb
         Sk9yO6z5sF6qZtRdAtpstzfpvN/BYJbpVr2mFSyyCOLhyy4pKgPCORXNR9sJ6aYp8qAB
         CnvRswcNes17X0CWe/P77Wwyd77CZRbRFusfLPpuYDd9LCht4ziLJ0lxNeU0GlNkkXcV
         oN1Q==
X-Gm-Message-State: APjAAAVmM4K2KVDDXC7WFqAbL3gMXi8QwhM41rfCYWgQOCIQTV1xL9Uq
        XXtjzOGZ98Hu4XcN0kHS9wdpiFN7Y/JGiEf1RhUu7bNykHljqg==
X-Google-Smtp-Source: APXvYqxV6oFAPQOovnuq+aPXQmkIG9HUdIgQ/dmoY6H6sFUB+2FkJF6pENJ2g6WPDpzIsL29gTeFrF7qh+bkS36YH0Y=
X-Received: by 2002:a1f:850c:: with SMTP id h12mr31268267vkd.70.1555059601428;
 Fri, 12 Apr 2019 02:00:01 -0700 (PDT)
MIME-Version: 1.0
References: <1555036767-31170-1-git-send-email-92siuyang@gmail.com> <878swf645i.fsf@miraculix.mork.no>
In-Reply-To: <878swf645i.fsf@miraculix.mork.no>
From:   Yang Xiao <92siuyang@gmail.com>
Date:   Fri, 12 Apr 2019 16:58:43 +0800
Message-ID: <CAKgHYH2vwWg=3KauUNZ98QHyPNOYqbbjc5-B58mo=SyoUoyouA@mail.gmail.com>
Subject: Re: [PATCH] USB: s2255 & stkwebcam: fix oops with malicious USB descriptors
To:     linux-usb@vger.kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thanks  for your response, firstly.

The affected version ranges from v3.7 to v5.1.

-------------------------------------------------------------
Below is the analysis of the vulnerability:

As said in the comment, the driver expects at least one valid endpoint.
If given malicious descritors that spcify 0 for the number of
endpoints, then there is a null pointer deference when calling
function usb_endpoint_is_bulk_in.

       for (i =3D 0; i < iface_desc->desc.bNumEndpoints; ++i) {
                endpoint =3D &iface_desc->endpoint[i].desc;
                if (!dev->read_endpoint && usb_endpoint_is_bulk_in(endpoint=
)) {
                        /* we found the bulk in endpoint */
                        dev->read_endpoint =3D endpoint->bEndpointAddress;
                }
        }

static inline int usb_endpoint_is_bulk_in(
const struct usb_endpoint_descriptor *epd)
{
return usb_endpoint_xfer_bulk(epd) && usb_endpoint_dir_in(epd);
}

static inline int usb_endpoint_xfer_bulk(
const struct usb_endpoint_descriptor *epd)
{
return ((epd->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) =3D=3D
USB_ENDPOINT_XFER_BULK);
}

There is a call to function usb_endpoint_is_bulk_in after assignment
to endpoint.
And the field bmAttributes is accessed in function
usb_endpoint_xfer_bulk (usb_endpoint_is_bulk_in ->
usb_endpoint_xfer_bulk).
Since the number of descriptors is 0, endpoint is assignment to NULL.
Then NULL pointer deference in function usb_endpoint_xfer_bulk (oops).

If you insist on a PoC, sorry for that. I found the vulnerability by
analyzing the code staticlly.

Below is the reply of your rant:
Everyone wants to build a secury Linux kernel with different ways.
Fuzzing, static analysis are all good ways.
And there are many missing fixes when a vulnerability is found indeed,
since there are much code clone in codebase.

I agree with you on your explain about alllocating CVE numbers to
arbitrary driver bugs.
Complaint is useless. As main developer of kernel, I think you can
disscuss the problem with other main developers.
There should be a baseline. Which vulnerabilities should be assigned
with a CVE number, and which should not.

However, if there are real bugs or vulnerabilities, we still need to
fix them, don't we?

Besides, I am sorry for not explaining the patch clearly when I
submitted the patch. I will try to analyse the possible vulnerability
when submitting patches next time.

Young


On Fri, Apr 12, 2019 at 4:04 PM Bj=C3=B8rn Mork <bjorn@mork.no> wrote:
>
> Please mark updated patches with a version number or some other
> indication that it replaces a previous patch.  Including a summary of
> changes is also normal.
>
> And speaking of normal:  We do build test our patches, don't we?
>
>
> Young Xiao <92siuyang@gmail.com> writes:
>
> > From: Young Xiao <YangX92@hotmail.com>
> >
> > The driver expects at least one valid endpoint. If given
> > malicious descriptors that specify 0 for the number of endpoints,
> > it will crash in the probe function.
>
> No, it won't.  Did you test this?  Can you provide the oops?
>
> This is perfectly fine as it is:
>
>         dev =3D kzalloc(sizeof(struct s2255_dev), GFP_KERNEL);
> ..
>         for (i =3D 0; i < iface_desc->desc.bNumEndpoints; ++i) {
>                 endpoint =3D &iface_desc->endpoint[i].desc;
>                 if (!dev->read_endpoint && usb_endpoint_is_bulk_in(endpoi=
nt)) {
>                         /* we found the bulk in endpoint */
>                         dev->read_endpoint =3D endpoint->bEndpointAddress=
;
>                 }
>         }
>
>         if (!dev->read_endpoint) {
>                 dev_err(&interface->dev, "Could not find bulk-in endpoint=
\n");
>                 goto errorEP;
>         }
>
> >  drivers/media/usb/stkwebcam/stk-webcam.c | 6 ++++++
>
> I didn't bother looking at this driver to see if your patch there makes
> more sense.  That is your home work now.  Please explain why you believe
> it is.  An actual oops would be good.
>
> <rant>
> Yes, and I do have some objections to this whole "protect against
> malicious devices".  How do you intend to protect against a USB device
> disguising itself as a keyboard or ethernet adapater or whatever?
> Allowing potentionally malicious devices is crazy enough for USB, and it
> gets completely wacko when people start talking about it in the context
> of firewire or PCIe
>
> Fixing bugs in drivers is fine. But it won't make any difference wrt
> security if you connect malicious devices to your system.  Don't do that
> if you want a secure system.
>
> Allocating CVE numbers to arbitrary driver bugs is just adding
> noise. This noise makes it harder for sysadmins and others to to notice
> the really important problems.  No one will care anymore if every kernel
> release fixes thousands of CVEs.  Which is pretty close to the truth if
> you start allocating CVE numbers to any bug with a security impact.
> </rant>
>
>
>
>
> Bj=C3=B8rn



--=20
Best regards!

Young
-----------------------------------------------------------
