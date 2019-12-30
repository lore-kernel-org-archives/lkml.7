Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B9EC2D0D3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 19:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9113120722
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 19:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbfL3TM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 14:12:27 -0500
Received: from ms.lwn.net ([45.79.88.28]:60510 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727278AbfL3TM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 14:12:26 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 80B74536;
        Mon, 30 Dec 2019 19:12:25 +0000 (UTC)
Date:   Mon, 30 Dec 2019 12:12:24 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Cc:     mchehab+samsung@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2 1/8] Documentation: convert nfs.txt to ReST
Message-ID: <20191230121224.1d9e795a@lwn.net>
In-Reply-To: <ddeb8a98f4c5c24df2f36e1ce1cc5ab4da6442a1.1577681164.git.dwlsalmeida@gmail.com>
References: <cover.1577681164.git.dwlsalmeida@gmail.com>
        <ddeb8a98f4c5c24df2f36e1ce1cc5ab4da6442a1.1577681164.git.dwlsalmeida@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Dec 2019 01:55:55 -0300
"Daniel W. S. Almeida" <dwlsalmeida@gmail.com> wrote:

> From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
> 
> This patch converts nfs.txt to RST. It also moves it to admin-guide.
> The reason for moving it is because this document contains information
> useful for system administrators, as noted on the following paragraph:
> 
> 'The purpose of this document is to provide information on some of the
> special features of the NFS client that can be configured by system
> administrators'.
> 
> Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>

This generally looks good, I just have one request...

>  Documentation/admin-guide/index.rst           |  1 +
>  Documentation/admin-guide/nfs/index.rst       |  9 ++
>  .../nfs/nfs-client.rst}                       | 91 ++++++++++---------
>  3 files changed, 58 insertions(+), 43 deletions(-)
>  create mode 100644 Documentation/admin-guide/nfs/index.rst
>  rename Documentation/{filesystems/nfs/nfs.txt => admin-guide/nfs/nfs-client.rst} (72%)
> 
> diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
> index 4405b7485312..4433f3929481 100644
> --- a/Documentation/admin-guide/index.rst
> +++ b/Documentation/admin-guide/index.rst
> @@ -76,6 +76,7 @@ configure specific aspects of kernel behavior to your liking.
>     device-mapper/index
>     efi-stub
>     ext4
> +   nfs/index
>     gpio/index
>     highuid
>     hw_random
> diff --git a/Documentation/admin-guide/nfs/index.rst b/Documentation/admin-guide/nfs/index.rst
> new file mode 100644
> index 000000000000..f5c0180f4e5e
> --- /dev/null
> +++ b/Documentation/admin-guide/nfs/index.rst
> @@ -0,0 +1,9 @@
> +=============
> +NFS
> +=============
> +
> +.. toctree::
> +    :maxdepth: 1
> +
> +    nfs-client
> +
> diff --git a/Documentation/filesystems/nfs/nfs.txt b/Documentation/admin-guide/nfs/nfs-client.rst
> similarity index 72%
> rename from Documentation/filesystems/nfs/nfs.txt
> rename to Documentation/admin-guide/nfs/nfs-client.rst
> index f2571c8bef74..f01bf6a6c207 100644
> --- a/Documentation/filesystems/nfs/nfs.txt
> +++ b/Documentation/admin-guide/nfs/nfs-client.rst
> @@ -1,3 +1,6 @@
> +==========
> +NFS Client
> +==========
>  
>  The NFS client
>  ==============
> @@ -59,10 +62,11 @@ The DNS resolver
>  
>  NFSv4 allows for one server to refer the NFS client to data that has been
>  migrated onto another server by means of the special "fs_locations"
> -attribute. See
> -	http://tools.ietf.org/html/rfc3530#section-6
> -and
> -	http://tools.ietf.org/html/draft-ietf-nfsv4-referrals-00
> +attribute. See `RFC3530 Section 6: Filesystem Migration and Replication`_ and
> +`Implementation Guide for Referrals in NFSv4`_.
> +
> +.. _RFC3530 Section 6\: Filesystem Migration and Replication: http://tools.ietf.org/html/rfc3530#section-6
> +.. _Implementation Guide for Referrals in NFSv4: http://tools.ietf.org/html/draft-ietf-nfsv4-referrals-00
>  
>  The fs_locations information can take the form of either an ip address and
>  a path, or a DNS hostname and a path. The latter requires the NFS client to
> @@ -72,16 +76,16 @@ upcall to allow userland to provide this service.
>  Assuming that the user has the 'rpc_pipefs' filesystem mounted in the usual
>  /var/lib/nfs/rpc_pipefs, the upcall consists of the following steps:
>  
> -   (1) The process checks the dns_resolve cache to see if it contains a
> +   #.  The process checks the dns_resolve cache to see if it contains a

It really only occurs to me now that we probaby shouldn't use the "#"
notation.  If we truly need an *enumerated* list, meaning that the numbers
are an important part of reading the list, then we should retain the
numbers in the plain-text version, even if that means we occasionally have
to change them if the list changes.  If, instead, the numbers aren't
important, we should just use bullets instead.

In this case, we have an explicit sequence of events, so the numbers should
probably remain.

Thanks,

jon
