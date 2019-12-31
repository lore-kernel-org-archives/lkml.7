Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343C7C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 22:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06622206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 22:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QERVFuI1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfLaWy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 17:54:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25251 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727054AbfLaWy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 17:54:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577832865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=slmh9bW+4V4Ot0eIs6GceXv6tZVqhiaH5L3lUPXogb8=;
        b=QERVFuI1GnIfl0T8YJovza3lKcxTI+kD+rVqA7JEyDl9EGIyGqXNtBwXfwaYwwyzpQz3PV
        5koAnTrR3g8qZizC/657rx+YS248Nlxf/+lDldoqgpUWidqTgu9uUpBXmAPwYYIz3A1kLm
        K/hmzJBvnkaFDvA0/WPtceLo5TzgWzM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-NwmcAXVlPQSfYh0kDQn1ZQ-1; Tue, 31 Dec 2019 17:54:22 -0500
X-MC-Unique: NwmcAXVlPQSfYh0kDQn1ZQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7AE21107ACC5;
        Tue, 31 Dec 2019 22:54:20 +0000 (UTC)
Received: from [127.0.0.1] (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8863960579;
        Tue, 31 Dec 2019 22:54:19 +0000 (UTC)
Subject: Re: FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        David Sterba <dsterba@suse.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191228143651.bjb4sjirn2q3xup4@pali>
From:   Eric Sandeen <sandeen@redhat.com>
Message-ID: <517472d1-c686-2f18-4e0b-000cda7e88c7@redhat.com>
Date:   Tue, 31 Dec 2019 16:54:18 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191228143651.bjb4sjirn2q3xup4@pali>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/19 6:36 AM, Pali Roh=C3=A1r wrote:
> Hello!
>=20
> I see that you have introduced in commit 62750d0 two new IOCTLs for
> filesyetems: FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL.
>=20
> I would like to ask, are these two new ioctls mean to be generic way fo=
r
> userspace to get or set fs label independently of which filesystem is
> used? Or are they only for btrfs?

The reason it was lifted out of btrfs to the vfs is so that other filesys=
tems
can use the same interface.  However, it is up to each filesystem to impl=
ement
it (and to interpret what's been written to or read from disk.)

> Because I was not able to find any documentation for it, what is format
> of passed buffer... null-term string? fixed-length? and in which
> encoding? utf-8? latin1? utf-16? or filesystem dependent?

It simply copies the bits from the memory location you pass in, it knows
nothing of encodings.

For the most part it's up to the filesystem's own utilities to do any
interpretation of the resulting bits on disk, null-terminating maximal-le=
ngth
label strings, etc.

-Eric

