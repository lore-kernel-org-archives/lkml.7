Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFC0C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 08:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B17222C7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 08:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O/Sql3wg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfKSIG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 03:06:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44415 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725815AbfKSIG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 03:06:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574150815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=peBFeZBSIFoRyfdzCDofdZLdSrtQ4P2nsRptfr1beLg=;
        b=O/Sql3wg89qx9zx3MCnbxJerd40Cq9SFulthOTnE/sDkdY4EzP8+eU/aylIHwayuLjlNYv
        y1Zg99FvsnBbiQJ/1yhaBLPVFlEdG2pIYajBKz9H60Qks9dbTxBo+9Ot25BMPPRrEeWQzE
        8IjSGJDFNWgnBLY587iQ7Px01eMz/Zo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-0V4ADOU1NgGPbytOBd64YA-1; Tue, 19 Nov 2019 03:06:52 -0500
Received: by mail-wr1-f72.google.com with SMTP id l3so17862043wrx.21
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 00:06:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RDyIhP1lituwrrdUjrW2HqGtKEzkvT1HMoFvvsAJST4=;
        b=jZoE61pEwYvMNoKh8LEddfYp+ZSOOxL5UKvy8zwDUfHhF7o3vFn/1G83W3CREXUUyg
         l4pOJgO5U4dH/w4r7EkyytETiM9sjWIly+4XZzGoBCQsXvKgqs6dAHzD3xYl+x61CLEd
         uI4jYtxortGeXA7OYJikzR0RSejFrMC3ZGqRimWNyHv4z8lY4mIRuc7Ip2OIHsJIupz9
         /yX17JFGBz3vfTxMHGYMGdeDqbGDjNaPVCQCh0DLFyY4LPrUqSaXX+cszUbekbrVGlKc
         5RVeAVF4BJRNMMKt5ucYhBQdn+WV/ldiGEKPvIwBrUWBFzem2NTJlijMwev9tak182rk
         7ZMg==
X-Gm-Message-State: APjAAAVdQbTTF7HnbMVA+Jn2QdaCStoYH8fr0Jo9cTVGZFcVELSZ1UAG
        WM/jI/tzEpKe/G5Esz+mrjalrEgVCUEmB7f0Z+VlnLYXAaiqtt/Bg7nMm1FxRxNr9gslTPMWjfi
        v15wpXPXpJ0qc5ivo3MefwUW9
X-Received: by 2002:a1c:e915:: with SMTP id q21mr3545010wmc.148.1574150811357;
        Tue, 19 Nov 2019 00:06:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqweN29oWgnsRUQu3ba9JAi6DKXYNnVg75X0GqPz5hfjXF+W0zn9gYT06hx/VVLTVUq4aHtG3g==
X-Received: by 2002:a1c:e915:: with SMTP id q21mr3544989wmc.148.1574150811144;
        Tue, 19 Nov 2019 00:06:51 -0800 (PST)
Received: from steredhat.homenet.telecomitalia.it (a-nu5-32.tin.it. [212.216.181.31])
        by smtp.gmail.com with ESMTPSA id b14sm2183532wmj.18.2019.11.19.00.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 00:06:50 -0800 (PST)
Date:   Tue, 19 Nov 2019 09:06:48 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     kbuild test robot <lkp@intel.com>, davem@davemloft.net
Cc:     kbuild-all@lists.01.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH linux-next] vsock/vmci: vmci_vsock_cb_host_called can
 be static
Message-ID: <20191119080648.yghtetswmf2iploa@steredhat.homenet.telecomitalia.it>
References: <201911190014.3ixYVAbj%lkp@intel.com>
 <20191118165615.y3kx2zkulexkoqwy@4978f4969bb8>
MIME-Version: 1.0
In-Reply-To: <20191118165615.y3kx2zkulexkoqwy@4978f4969bb8>
X-MC-Unique: 0V4ADOU1NgGPbytOBd64YA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 12:56:15AM +0800, kbuild test robot wrote:
>=20
> Fixes: b1bba80a4376 ("vsock/vmci: register vmci_transport only when VMCI =
guest/host are active")
> Signed-off-by: kbuild test robot <lkp@intel.com>
> ---
>  vmci_driver.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/misc/vmw_vmci/vmci_driver.c b/drivers/misc/vmw_vmci/=
vmci_driver.c
> index 95fed4664a2d2..cbb706dabede9 100644
> --- a/drivers/misc/vmw_vmci/vmci_driver.c
> +++ b/drivers/misc/vmw_vmci/vmci_driver.c
> @@ -30,7 +30,7 @@ static bool vmci_host_personality_initialized;
> =20
>  static DEFINE_MUTEX(vmci_vsock_mutex); /* protects vmci_vsock_transport_=
cb */
>  static vmci_vsock_cb vmci_vsock_transport_cb;
> -bool vmci_vsock_cb_host_called;
> +static bool vmci_vsock_cb_host_called;
> =20
>  /*
>   * vmci_get_context_id() - Gets the current context ID.
>=20

My fault!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

