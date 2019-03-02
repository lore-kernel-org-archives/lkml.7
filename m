Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F3FC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 23:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10C2D20838
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 23:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXyaoNnA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbfCBXe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 18:34:27 -0500
Received: from mail-io1-f48.google.com ([209.85.166.48]:45604 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfCBXe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 18:34:27 -0500
Received: by mail-io1-f48.google.com with SMTP id x9so1213642iog.12;
        Sat, 02 Mar 2019 15:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=xvAAARodJC33XZbh124XRYNJ3TqKZUFQn/o8TTEXTTw=;
        b=QXyaoNnAysfPr6ZIw6l9nJ8gy0pdCHgbsGVJzB1XDIFCWBSzVZxeZr3SxqnuSooP7A
         OBAukGp1AvP6y4b4EMLZgVbtionWqTG5Nqggs5qdr6mnK1nyI4phmGi+ERl6rWaoaIbP
         iZtXPZDH712qG2ydDzyvfXD6HPLLJVnCWQ99xCJSBKCys/RDgWWdY8B/2CK7y4wmuXnG
         6WREV2xVtpVxWhmwKxVBvAFvNATRqEyeU9CeFSdb02xkzFcn9uJLm4wVVmw6kY3NsS0Z
         sLyyT/4t9RxeRUenRhbbrPQFLuDGgV7+N7C2GN6b5xB6GIN5nfEc3fkYkUuoqDvN7gHd
         aD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=xvAAARodJC33XZbh124XRYNJ3TqKZUFQn/o8TTEXTTw=;
        b=hYGmS0encJmhnLZSXoDEVfV1ZKNle+l+O/7KCOojrlZOfrkSrXZY95QXTzLDNxDljS
         9GSCAN17rJpNbGEDwEYTrmf5+kHKs3VIctBzb09iAQtpk0MT4mrut8FHNr6frSoeqYQh
         4t0iAIauFCCyn16JqggniUhRcEagrnYy4E0Rrp4at8u3SANoOYd1uzhEybtwU5zHwZaK
         oAsZIF2d9V7jqWr4vTGtAxcE/xsI53qc/J1UkkMwIQCN3xt/usu++P3mFKvjcgtodf2N
         vVBAaFyTOMSeaseNTok279nn7Bn1kXRxDbmKetw0JHSUpIdMy10OHJHKiQjebVV3mpnm
         U4bA==
X-Gm-Message-State: APjAAAUlPaeW3Ot/SFmAjsx25DwARhLSV+LNpONz4qIQSRUXjvO5+9lp
        boF57fXb1gY8zTpCZce3w51vXilk9nQhRciNXd8=
X-Google-Smtp-Source: APXvYqzyAICsy0RBLJj8cd+b7wzUt22E9w6VQgg8n7aWnSUQUsGLkQJondhGVy3Yt8Pn0aUWZD+Gx5Qpuq4B4VgaGS4=
X-Received: by 2002:a6b:e219:: with SMTP id z25mr6149814ioc.116.1551569666078;
 Sat, 02 Mar 2019 15:34:26 -0800 (PST)
MIME-Version: 1.0
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Sat, 2 Mar 2019 15:34:15 -0800
Message-ID: <CAKgT0UeMqmojVrNV1i-DdY18EBwbJ_4zVTUggAWas5D5yeU1PQ@mail.gmail.com>
Subject: x86 VM Boot hang with latest linux-next
To:     snitzer@redhat.com, linux-next@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, dm-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So I have been seeing an issue with an intermittent boot hang on my
x86 KVM VM with the latest linux-next and have bisected it down to the
following commit:
1efa3bb79d3de8ca1b7f6770313a1fc0bebe25c7 is the first bad commit
commit 1efa3bb79d3de8ca1b7f6770313a1fc0bebe25c7
Author: Mike Snitzer <snitzer@redhat.com>
Date:   Fri Feb 22 11:23:01 2019 -0500

    dm: must allocate dm_noclone for stacked noclone devices

    Otherwise various lvm2 testsuite tests fail because the lower layers of
    the stacked noclone device aren't updated to allocate a new 'struct
    dm_clone' that reflects the upper layer bio that was issued to it.

    Fixes: 97a89458020b38 ("dm: improve noclone bio support")
    Reported-by: Mikulas Patocka <mpatocka@redhat.com>
    Signed-off-by: Mike Snitzer <snitzer@redhat.com>

What I am seeing is in about 3 out of 4 boots the startup just hangs
at the filesystem check stage with the following message:
[  OK  ] Reached target Local File Systems (Pre).
         Starting File System Check on /dev/=E2=80=A6127-ad57-426f-bb45-363=
950544c0c...
[    **] (1 of 2) A start job is running for=E2=80=A6n on device 252:2 (19s=
 / no limit)

I did some googling and it looks like a similar issue has been
reported for s390. Based on the request for data there I have the
following info:
[root@localhost ~]# dmsetup ls --tree
fedora-swap (253:1)
 =E2=94=94=E2=94=80 (252:2)
fedora-root (253:0)
 =E2=94=94=E2=94=80 (252:2)

[root@localhost ~]# dmsetup table
fedora-swap: 0 4194304 linear 252:2 2048
fedora-root: 0 31457280 linear 252:2 4196352
