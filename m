Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEE7C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 09:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7216C233FF
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 09:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Hc9GLAgO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfH2J2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 05:28:39 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43699 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfH2J2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 05:28:39 -0400
Received: by mail-io1-f68.google.com with SMTP id u185so1757889iod.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 02:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v06lta4MYVBJBZLQ73bBpIez3Zzb0/6n6ZDJgeZvvFA=;
        b=Hc9GLAgOOnaaXsF3NrbM7AecX7f3q0LEmVqWdNl+cCygzK/RxeejM05rD+PoBYvpNy
         iCfIvK00i3nYnz/7hEF1IyoD0raYoTA0Fi7pIXSNsQiydr+b2RWwANqNTLEGdoi4TVze
         EI0HrSen2CJeJvMGU2pb8OzX9tm5amIQIkLoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v06lta4MYVBJBZLQ73bBpIez3Zzb0/6n6ZDJgeZvvFA=;
        b=mYyjPNRO1xUAQ8WQ0r3klctv6pAHwhWsoioddFNpDpQByiZxDhLXFJlzpVI058xIYB
         D37MbbpQcGmhlnoi4SsU6OfEFi4zxPtbQZ/ed5p0HMW8dZHZjg8Q58wVvriULmqpJjq8
         xdExr4Ei/VQgoM//K9ipdzPjTYsHdvXA8sIGdy8qPfB2ASrQ1Dw9hmVYZTSNpWHZ95AG
         nHP1oQMPOzE0JgPx9MGFRkSzzDan7IZaaiuVg2HmtWuAxG4XR/rS9E9sNqR69tFFd4MH
         UzDHtk6H5odggRw/MwL8aig8Su3JyJeBIcGbFcJkAlPECfy82nVuhiac2Lekoj6bQMA7
         0p9g==
X-Gm-Message-State: APjAAAW39/s3O8bQp0F5gdEsxeTd0Q0D+TzvE8VVrTfOqE7LmoY7JKRe
        7inMzgAyNCk/o8wFlnoYoofmARzbw8/IcHOStfEK4Q==
X-Google-Smtp-Source: APXvYqyUavfINYtqJHGpZUBR9A9V8dAVHmilYmO0JxPFl0AJag7dkVSKSrPI4+FtMTzlVFjVPwtJnqsyT6kSq+5gC8c=
X-Received: by 2002:a5e:da48:: with SMTP id o8mr593380iop.252.1567070918305;
 Thu, 29 Aug 2019 02:28:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190821173742.24574-1-vgoyal@redhat.com>
In-Reply-To: <20190821173742.24574-1-vgoyal@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 29 Aug 2019 11:28:27 +0200
Message-ID: <CAJfpegv_XS=kLxw_FzWNM2Xao5wsn7oGbk3ow78gU8tpXwo-sg@mail.gmail.com>
Subject: Re: [PATCH v3 00/13] virtio-fs: shared file system for virtual machines
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 7:38 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> Hi,
>
> Here are the V3 patches for virtio-fs filesystem. This time I have
> broken the patch series in two parts. This is first part which does
> not contain DAX support. Second patch series will contain the patches
> for DAX support.
>
> I have also dropped RFC tag from first patch series as we believe its
> in good enough shape that it should get a consideration for inclusion
> upstream.

Pushed out to

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#for-next

Major changes compared to patchset:

 - renamed to "virtiofs".  Filesystem names don't usually have
underscore before "fs" postfix.

 - removed option parsing completely.  Virtiofs config is fixed to "-o
rootmode=040000,user_id=0,group_id=0,allow_other,default_permissions".
Does this sound reasonable?

There are miscellaneous changes, so needs to be thoroughly tested.

I think we also need something in
"Documentation/filesystems/virtiofs.rst" which describes the design
(how  request gets to userspace and back) and how to set up the
server, etc...  Stefan, Vivek can you do something like that?

Thanks,
Miklos
