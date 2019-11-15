Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B11AC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 08:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 718892072B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 08:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e9lHlgRW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfKOI0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 03:26:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20385 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727135AbfKOI0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 03:26:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573806381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xt7ctRiywIG1tpU0cT26zCBUdn9q3E2Aseumqp8v+zU=;
        b=e9lHlgRWsugelA1gTvRfjNDi97koBCuKCS7h6udcuchMc2hT3n4TRgmeXI6p2JKgWUp1Y1
        k2lPeQzuOUfYTE9eFF+d0iflnZOljJKjQ6ninjUugw8o4Bi7lyGUnOb6Rzj4Ecme8uRCBI
        Gp4KmKKkqQ1sBV7wCuy4nNye4hvAxaQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-MF5yWUTFN2Gmw0zPzyXQVg-1; Fri, 15 Nov 2019 03:26:20 -0500
Received: by mail-wm1-f69.google.com with SMTP id 2so6538081wmd.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 00:26:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RoXy81G7M/BfnHRZ4y2U2/JU3z4ekC5J7eZ1fYMw4CI=;
        b=fP6yjBz21wsXVhnER8i2bTstQ7ga8b0juLCNPgl7/GnnErdBVXkYISu5+auqcqiltj
         3EZ61ZC35mDN0rkXtxYJ+SrjJIHUE2hmg0jLDKyVO2PlvWVR+GN5t/VLA5O5KQrMADTs
         Ktd8DgVJpvZSIlFcT2Z4tBMhYQE9UcpzSeA19ZFAsVqQYp+rzzDCynhHEszyUL3o3ee2
         EOtZdon8+Ot4d3j0W5yjMYkWxQKIDsIrk16rZAiOGlqtZ3K26JEUz64PX31HiOC+rreT
         z3QMyBt7R5MpRX0y4Si7Ii02hyC2TZDoA/2deMAoOos3LAhZDei+CP05SSC8BuOfAqWN
         7YTQ==
X-Gm-Message-State: APjAAAWI/MpKdUkyE8y0ClVnCwousJ6J4iKBFJjDK7DMdZpga92SsbjA
        CxCaSQuYNy0Uc6n4oPTeuxyBe0jORlr43GQ5pHd7stotT1G6GKtWGMATh2oLMzQMIX39n7r5GCD
        I/xxsSvdrXlBJY8NovD4XUdz5
X-Received: by 2002:adf:f78c:: with SMTP id q12mr13056398wrp.71.1573806379268;
        Fri, 15 Nov 2019 00:26:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqyvFtcZcCmdybEhREmfVJhjMJWYu5vgKjT2yNfXmAdZcdboUyo4lpokec2THBO5n/9IFhwgFw==
X-Received: by 2002:adf:f78c:: with SMTP id q12mr13056369wrp.71.1573806378928;
        Fri, 15 Nov 2019 00:26:18 -0800 (PST)
Received: from steredhat (a-nu5-32.tin.it. [212.216.181.31])
        by smtp.gmail.com with ESMTPSA id 19sm12549850wrc.47.2019.11.15.00.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 00:26:18 -0800 (PST)
Date:   Fri, 15 Nov 2019 09:26:15 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, sthemmin@microsoft.com, arnd@arndb.de,
        jhansen@vmware.com, jasowang@redhat.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        mst@redhat.com, haiyangz@microsoft.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        sashal@kernel.org, kys@microsoft.com, decui@microsoft.com,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH net-next v2 00/15] vsock: add multi-transports support
Message-ID: <20191115082615.uouzvisaz27xny4e@steredhat>
References: <20191114095750.59106-1-sgarzare@redhat.com>
 <20191114.181251.451070581625618487.davem@davemloft.net>
MIME-Version: 1.0
In-Reply-To: <20191114.181251.451070581625618487.davem@davemloft.net>
X-MC-Unique: MF5yWUTFN2Gmw0zPzyXQVg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 06:12:51PM -0800, David Miller wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> Date: Thu, 14 Nov 2019 10:57:35 +0100
>=20
> > Most of the patches are reviewed by Dexuan, Stefan, and Jorgen.
> > The following patches need reviews:
> > - [11/15] vsock: add multi-transports support
> > - [12/15] vsock/vmci: register vmci_transport only when VMCI guest/host
> >           are active
> > - [15/15] vhost/vsock: refuse CID assigned to the guest->host transport
> >=20
> > RFC: https://patchwork.ozlabs.org/cover/1168442/
> > v1: https://patchwork.ozlabs.org/cover/1181986/
>=20
> I'm applying this as-is, if there is feedback changes required on 11,
> 12, and 15 please deal with this using follow-up patches.

Thank you very much,
Stefano

