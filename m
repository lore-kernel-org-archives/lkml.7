Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B04C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F302084B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LIRY5QDr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbfLDPJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 10:09:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47345 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727910AbfLDPJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:09:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575472175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JpDNGnaXwkcWb4OqMO4sY3OzA9+qHY77UsQ1KQYrk/U=;
        b=LIRY5QDrtVHlIMNcMO9elA3YVX2YaiP1YCtKSrzENkOfcgFxFPx7YgPAyd6kf+ee5Qavqw
        MkvjmGkbmUv47/33fkHk45eFrhx2nsRi7D4y8pfbOGBgW3AFeoZwXHhNH4kOq0C+rpwKW8
        uZrZduF/STo8RcGSPNu7xwd5CHQIIXg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-Lm1CiUrXMdCtDnXyrPgbkg-1; Wed, 04 Dec 2019 10:09:30 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF22A593C7;
        Wed,  4 Dec 2019 15:09:28 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id B9E38691B1;
        Wed,  4 Dec 2019 15:09:23 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed,  4 Dec 2019 16:09:27 +0100 (CET)
Date:   Wed, 4 Dec 2019 16:09:21 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pedro Alves <palves@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2 1/4] introduce set_restart_fn() and
 arch_set_restart_data()
Message-ID: <20191204150921.GA14871@redhat.com>
References: <20191126110659.GA14042@redhat.com>
 <20191203141239.GA30688@redhat.com>
 <20191203141305.GB30688@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191203141305.GB30688@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: Lm1CiUrXMdCtDnXyrPgbkg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03, Oleg Nesterov wrote:
>
> +static inline long set_restart_fn(struct restart_block *restart,
> +=09=09=09=09=09long (*fn)(struct restart_block *))
> +{
> +=09restart->fn =3D fn;
> +=09arch_set_restart_data(restart);
> +=09return -ERESTART_RESTARTBLOCK;

this needs include/errno.h (thank you kbuild test robot), I am sending v3.

Oleg.

