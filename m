Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F63BC282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB839206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="cvm843qX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732521AbfDQOge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:36:34 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46921 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731565AbfDQOgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:36:31 -0400
Received: by mail-lj1-f196.google.com with SMTP id h21so22637592ljk.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 07:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aYpvTFf0qZElPLw/muGHvS8dE/2mug1cDst2X31iqmw=;
        b=cvm843qXLqUQ0ltX6klK7YVQl9QU/F4aGuAvL7ZAzJSlveFKDSdJ/lNsrZY0hxF94f
         qP1hPE3n1Ot8gaYMp8wC/hvN2Z7/SQnGr59BCvOm0yP6kJaUN52w4VBhRgv7IUZR5T3m
         VeQzZwHgtMGQyLOkgjkmjORqQEi/+geEFtMWV7pgSP8zGZjHkNi37mNKrzZhEYah/QS+
         dXsqOCRU/pl2Nyu4WzlULuW+MuIcWsYm+4+riUl89XEnuwCf7X6XKFVMAHBGAhpHQV+2
         Oe4wLKr+lnkNMEtxvzkcs7zbP72J1xsSeFtJGKyoXZb3b4j47HZy6rHsjFC7u9zUh1lg
         FG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aYpvTFf0qZElPLw/muGHvS8dE/2mug1cDst2X31iqmw=;
        b=n+F7sHiuB7T7TyBx2xtrAhegemqzKoVY1wr1W7u1+TkqOx2q4NhHn5MEeSYjOPzU2o
         UPlmiwsGzkV5QE9+V+DZk0EkaVtfici7/lSGMEzaTXRcWz73lg9IrVEMtLPmth4W3wAM
         wL1WE3fBotpHowAxOgW4+ZTLgHuProKrRjMWp0USVGDAcd2AxbuVsbc/ZXmLHjOjtyi9
         12y5sLctQtU64+BLwGtHWzXsqp5D8yDCIIJiUX+fpMdYB6rjV0H1gV2no0LtBmg/oVVR
         YlpPBEWgzdnYIlInReN9sndNvUKxnnuu14+Wp82lANlrvtGhsNEMrMbpmmC7yKUtyQ6p
         3lSg==
X-Gm-Message-State: APjAAAXxTzbuy54u0KGfVmhtqP7Vzgxf1L2rps3hQY0uputZdQfQNkHJ
        7q9qtNmflY2S+pQIWR7sc8JztGBqx5clEGxYhF8AEDE=
X-Google-Smtp-Source: APXvYqzIRq1TtmAHQvMfI9/2v3ZwCpClKzw6wpPHGPILEdVRcVNVPodTxE9XbtFfz2uqj5/VBWvEfh8wJJLmfxPNes8=
X-Received: by 2002:a2e:8108:: with SMTP id d8mr21571767ljg.57.1555511787821;
 Wed, 17 Apr 2019 07:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1555382110.git.mchehab+samsung@kernel.org> <104211eb0db14790ad328fff7ad7f712d8d647f9.1555382110.git.mchehab+samsung@kernel.org>
In-Reply-To: <104211eb0db14790ad328fff7ad7f712d8d647f9.1555382110.git.mchehab+samsung@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 17 Apr 2019 10:36:16 -0400
Message-ID: <CAHC9VhTcTifp1v9JfGLNw+4HPvqMjYsX0gM2tXZDOhmxUHt+oA@mail.gmail.com>
Subject: Re: [PATCH 23/57] docs: netlabel: convert it to ReST
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        netdev@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 10:56 PM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
>
> Convert netlabel documentation to ReST.
>
> This was trivial: just add proper title markups.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/netlabel/cipso_ipv4.txt    | 19 +++++++++++++------
>  Documentation/netlabel/introduction.txt  | 16 +++++++++++-----
>  Documentation/netlabel/lsm_interface.txt | 16 +++++++++++-----
>  3 files changed, 35 insertions(+), 16 deletions(-)

Thanks for doing this.  I should probably revisit these docs to make
sure they are still valid/correct; if nothing else that email address
is from two employers ago (my apologies to the current email address
holder).

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/Documentation/netlabel/cipso_ipv4.txt b/Documentation/netlabel/cipso_ipv4.txt
> index a6075481fd60..cbd3f3231221 100644
> --- a/Documentation/netlabel/cipso_ipv4.txt
> +++ b/Documentation/netlabel/cipso_ipv4.txt
> @@ -1,10 +1,13 @@
> +===================================
>  NetLabel CIPSO/IPv4 Protocol Engine
> -==============================================================================
> +===================================
> +
>  Paul Moore, paul.moore@hp.com
>
>  May 17, 2006
>
> - * Overview
> +Overview
> +========
>
>  The NetLabel CIPSO/IPv4 protocol engine is based on the IETF Commercial
>  IP Security Option (CIPSO) draft from July 16, 1992.  A copy of this
> @@ -13,7 +16,8 @@ draft can be found in this directory
>  it to an RFC standard it has become a de-facto standard for labeled
>  networking and is used in many trusted operating systems.
>
> - * Outbound Packet Processing
> +Outbound Packet Processing
> +==========================
>
>  The CIPSO/IPv4 protocol engine applies the CIPSO IP option to packets by
>  adding the CIPSO label to the socket.  This causes all packets leaving the
> @@ -24,7 +28,8 @@ label by using the NetLabel security module API; if the NetLabel "domain" is
>  configured to use CIPSO for packet labeling then a CIPSO IP option will be
>  generated and attached to the socket.
>
> - * Inbound Packet Processing
> +Inbound Packet Processing
> +=========================
>
>  The CIPSO/IPv4 protocol engine validates every CIPSO IP option it finds at the
>  IP layer without any special handling required by the LSM.  However, in order
> @@ -33,7 +38,8 @@ NetLabel security module API to extract the security attributes of the packet.
>  This is typically done at the socket layer using the 'socket_sock_rcv_skb()'
>  LSM hook.
>
> - * Label Translation
> +Label Translation
> +=================
>
>  The CIPSO/IPv4 protocol engine contains a mechanism to translate CIPSO security
>  attributes such as sensitivity level and category to values which are
> @@ -42,7 +48,8 @@ Domain Of Interpretation (DOI) definition and are configured through the
>  NetLabel user space communication layer.  Each DOI definition can have a
>  different security attribute mapping table.
>
> - * Label Translation Cache
> +Label Translation Cache
> +=======================
>
>  The NetLabel system provides a framework for caching security attribute
>  mappings from the network labels to the corresponding LSM identifiers.  The
> diff --git a/Documentation/netlabel/introduction.txt b/Documentation/netlabel/introduction.txt
> index 3caf77bcff0f..9333bbb0adc1 100644
> --- a/Documentation/netlabel/introduction.txt
> +++ b/Documentation/netlabel/introduction.txt
> @@ -1,10 +1,13 @@
> +=====================
>  NetLabel Introduction
> -==============================================================================
> +=====================
> +
>  Paul Moore, paul.moore@hp.com
>
>  August 2, 2006
>
> - * Overview
> +Overview
> +========
>
>  NetLabel is a mechanism which can be used by kernel security modules to attach
>  security attributes to outgoing network packets generated from user space
> @@ -12,7 +15,8 @@ applications and read security attributes from incoming network packets.  It
>  is composed of three main components, the protocol engines, the communication
>  layer, and the kernel security module API.
>
> - * Protocol Engines
> +Protocol Engines
> +================
>
>  The protocol engines are responsible for both applying and retrieving the
>  network packet's security attributes.  If any translation between the network
> @@ -24,7 +28,8 @@ the NetLabel kernel security module API described below.
>  Detailed information about each NetLabel protocol engine can be found in this
>  directory.
>
> - * Communication Layer
> +Communication Layer
> +===================
>
>  The communication layer exists to allow NetLabel configuration and monitoring
>  from user space.  The NetLabel communication layer uses a message based
> @@ -33,7 +38,8 @@ formatting of these NetLabel messages as well as the Generic NETLINK family
>  names can be found in the 'net/netlabel/' directory as comments in the
>  header files as well as in 'include/net/netlabel.h'.
>
> - * Security Module API
> +Security Module API
> +===================
>
>  The purpose of the NetLabel security module API is to provide a protocol
>  independent interface to the underlying NetLabel protocol engines.  In addition
> diff --git a/Documentation/netlabel/lsm_interface.txt b/Documentation/netlabel/lsm_interface.txt
> index 638c74f7de7f..026fc267f798 100644
> --- a/Documentation/netlabel/lsm_interface.txt
> +++ b/Documentation/netlabel/lsm_interface.txt
> @@ -1,10 +1,13 @@
> +========================================
>  NetLabel Linux Security Module Interface
> -==============================================================================
> +========================================
> +
>  Paul Moore, paul.moore@hp.com
>
>  May 17, 2006
>
> - * Overview
> +Overview
> +========
>
>  NetLabel is a mechanism which can set and retrieve security attributes from
>  network packets.  It is intended to be used by LSM developers who want to make
> @@ -12,7 +15,8 @@ use of a common code base for several different packet labeling protocols.
>  The NetLabel security module API is defined in 'include/net/netlabel.h' but a
>  brief overview is given below.
>
> - * NetLabel Security Attributes
> +NetLabel Security Attributes
> +============================
>
>  Since NetLabel supports multiple different packet labeling protocols and LSMs
>  it uses the concept of security attributes to refer to the packet's security
> @@ -24,7 +28,8 @@ configuration.  It is up to the LSM developer to translate the NetLabel
>  security attributes into whatever security identifiers are in use for their
>  particular LSM.
>
> - * NetLabel LSM Protocol Operations
> +NetLabel LSM Protocol Operations
> +================================
>
>  These are the functions which allow the LSM developer to manipulate the labels
>  on outgoing packets as well as read the labels on incoming packets.  Functions
> @@ -32,7 +37,8 @@ exist to operate both on sockets as well as the sk_buffs directly.  These high
>  level functions are translated into low level protocol operations based on how
>  the administrator has configured the NetLabel subsystem.
>
> - * NetLabel Label Mapping Cache Operations
> +NetLabel Label Mapping Cache Operations
> +=======================================
>
>  Depending on the exact configuration, translation between the network packet
>  label and the internal LSM security identifier can be time consuming.  The
> --
> 2.20.1
>


-- 
paul moore
www.paul-moore.com
