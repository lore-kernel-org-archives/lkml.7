Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5846BC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A14207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MRKiyWgI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgAFQSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 11:18:49 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56504 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726448AbgAFQSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 11:18:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578327524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QNNd57mAnrqQ4gj56JtwDmDuZj/pHKaPcy0phaLSyq8=;
        b=MRKiyWgIVgQH7kl44KX7NdZLiOcALrQg7O5D9OZl11vqqa9p+1NiKyUb70W28cMaP1NFrX
        eSQybWdkhx37DRhKp14Lvz0fyXVPzAIJ4gBoaQGFDWlv+/2H1b+TAp0ZE6NcqOVACSUj/b
        +0uTMekyfwPFvhEzEHpsxiPqk8ncbJc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-QQb6tZyZMbaeAD5EPL2TtQ-1; Mon, 06 Jan 2020 11:18:42 -0500
X-MC-Unique: QQb6tZyZMbaeAD5EPL2TtQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DC9A1951265;
        Mon,  6 Jan 2020 16:18:41 +0000 (UTC)
Received: from localhost (ovpn-116-171.ams2.redhat.com [10.36.116.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A5A47DB48;
        Mon,  6 Jan 2020 16:18:37 +0000 (UTC)
Date:   Mon, 6 Jan 2020 16:18:36 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jing Liu <jing2.liu@linux.intel.com>
Cc:     virtio-dev@lists.oasis-open.org, slp@redhat.com,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Zha Bin <zhabin@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>
Subject: Re: [virtio-dev][PATCH v1 1/2] virtio-mmio: Add MSI and different
 notification address support
Message-ID: <20200106161836.GB350142@stefanha-x1.localdomain>
References: <1576855504-34947-1-git-send-email-jing2.liu@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <1576855504-34947-1-git-send-email-jing2.liu@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eJnRUKwClWJh1Khz"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2019 at 11:25:03PM +0800, Jing Liu wrote:
> Upgrade virtio-mmio to version 3, with the abilities to support
> MSI interrupt and notification features.
>=20
> The details of version 2 will be appended as part of legacy interface
> in next patch.

Cool, MSI is useful.  Not a full review, but some comments below...

>=20
> Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
> Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
> ---
>  content.tex  | 191 ++++++++++++++++++++++++++++++++++++++++++++++++-----=
------
>  msi-status.c |   5 ++
>  2 files changed, 163 insertions(+), 33 deletions(-)
>  create mode 100644 msi-status.c
>=20
> diff --git a/content.tex b/content.tex
> index d68cfaf..eaaffec 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -1597,9 +1597,9 @@ \subsection{MMIO Device Register Layout}\label{sec:=
Virtio Transport Options / Vi
>    }=20
>    \hline
>    \mmioreg{Version}{Device version number}{0x004}{R}{%
> -    0x2.
> +    0x3.
>      \begin{note}
> -      Legacy devices (see \ref{sec:Virtio Transport Options / Virtio Ove=
r MMIO / Legacy interface}~\nameref{sec:Virtio Transport Options / Virtio O=
ver MMIO / Legacy interface}) used 0x1.
> +      Legacy devices (see \ref{sec:Virtio Transport Options / Virtio Ove=
r MMIO / Legacy interface}~\nameref{sec:Virtio Transport Options / Virtio O=
ver MMIO / Legacy interface}) used 0x1 or 0x2.

"Legacy devices" refers to pre-VIRTIO 1.0 devices.  0x2 is VIRTIO 1.0
and therefore not "Legacy".  I suggest the following wording:

      Legacy devices (see \ref{sec:Virtio Transport Options / Virtio Over M=
MIO / Legacy interface}~\nameref{sec:Virtio Transport Options / Virtio Over=
 MMIO / Legacy interface}) used 0x1.
+     VIRTIO 1.0 and 1.1 used 0x2.

Did you consider using a transport feature bit instead of changing the
device version number?  Feature bits allow more graceful compatibility:
old drivers will continue to work with new devices and new drivers will
continue to work with old devices.

>      \end{note}
>    }
>    \hline=20
> @@ -1671,25 +1671,23 @@ \subsection{MMIO Device Register Layout}\label{se=
c:Virtio Transport Options / Vi
>      accesses apply to the queue selected by writing to \field{QueueSel}.
>    }
>    \hline=20
> -  \mmioreg{QueueNotify}{Queue notifier}{0x050}{W}{%
> -    Writing a value to this register notifies the device that
> -    there are new buffers to process in a queue.
> +  \mmioreg{QueueNotify}{Queue notifier}{0x050}{RW}{%
> +    Reading from the register returns the virtqueue notification configu=
ration.
> =20
> -    When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
> -    the value written is the queue index.
> +    See \ref{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-spec=
ific Initialization And Device Operation / Notification Address}
> +    for the configuration format.
> =20
> -    When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
> -    the \field{Notification data} value has the following format:
> +    Writing when the notification address calculated by the notification=
 configuration
> +    is just located at this register.

I don't understand this sentence.  What happens when the driver writes
to this register?

> =20
> -    \lstinputlisting{notifications-le.c}
> -
> -    See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec:Virtque=
ues / Driver notifications}
> -    for the definition of the components.
> +    See \ref{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-spec=
ific Initialization And Device Operation / Available Buffer Notifications}
> +    to see the notification data format.
>    }
>    \hline=20
>    \mmioreg{InterruptStatus}{Interrupt status}{0x60}{R}{%
>      Reading from this register returns a bit mask of events that
> -    caused the device interrupt to be asserted.
> +    caused the device interrupt to be asserted. This is only used
> +    when MSI is not enabled.
>      The following events are possible:
>      \begin{description}
>        \item[Used Buffer Notification] - bit 0 - the interrupt was assert=
ed
> @@ -1703,7 +1701,7 @@ \subsection{MMIO Device Register Layout}\label{sec:=
Virtio Transport Options / Vi
>    \mmioreg{InterruptACK}{Interrupt acknowledge}{0x064}{W}{%
>      Writing a value with bits set as defined in \field{InterruptStatus}
>      to this register notifies the device that events causing
> -    the interrupt have been handled.
> +    the interrupt have been handled. This is only used when MSI is not e=
nabled.
>    }
>    \hline=20
>    \mmioreg{Status}{Device status}{0x070}{RW}{%
> @@ -1762,6 +1760,31 @@ \subsection{MMIO Device Register Layout}\label{sec=
:Virtio Transport Options / Vi
>      \field{SHMSel} is unused) results in a base address of
>      0xffffffffffffffff.
>    }
> +  \hline
> +  \mmioreg{MsiStatus}{MSI status}{0x0c0}{R}{%
> +    Reading from this register returns the global MSI enable/disable sta=
tus and maximum
> +    number of virtqueues that device supports.
> +    \lstinputlisting{msi-status.c}
> +  }

Why is it necessary to combine the number of virtqueues and global
MSI enable/disable into a single 16-bit field?

virtio-mmio uses 32-bit registers.  It doesn't try hard to save register
space so it's strange to do it here (11-bit number of virtqueue field
but 32-bit QueueSel field).

> +  \hline
> +  \mmioreg{MsiCmd}{MSI command}{0x0c2}{W}{%
> +    The driver writes to this register with appropriate operators and ar=
guments to
> +    execute MSI command to device.
> +    Operators supported is setting global MSI enable/disable status
> +    and updating MSI configuration to device.

If the global MSI enable/disable state is written in this register,
consider making this register readable too so the global MSI
enable/disable state can be read from it.

--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4TXdwACgkQnKSrs4Gr
c8hI0wf/b4/kdEZSyyCvjrzLMUFLE4zUiW+I2z1Knv3F8s7oJmnZFz3ZiKgdV1u6
BUNfm8vN/u/mDpKN77ZXxwE2mJguapV1A3jmagkHCvXmLQArehE7bYOvTASPwAAY
KimoFyNn+X+oduk3sjMHtHRikiMz08ByDp7d99y7ZSsWfc1c7MLU4ByBWf9GUwkU
36ybP/SJO98gQOUMJIHb1L29Wh/PU1ByCuNU0w3fJYN/XpXLRqjo9t7CfkZKoGte
jjDIhkQCEnJCXPVlDP1vRk82GkFG6uobMM/Ykd5AlWmAVtTb73Ba7V3BQEUmiDo4
dcwjNAvvCcgDp9+4Oak7946xu0y6Tg==
=Ve9u
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--

