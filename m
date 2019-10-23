Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7841CCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FBB22084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ar3RZk5Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403797AbfJWJVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 05:21:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57372 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2403757AbfJWJVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 05:21:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571822473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GMpXAQSd5E7qm/XtkcXKzvy4PNfzv6ftxdxzuMplztA=;
        b=Ar3RZk5QwhCbmhYwDxH0Pxmo8kTm7ru6x2elK73wMArBgpCsFxL/vGdcFIJ78f+W8Tn1Xl
        pxKb9zic+Q7dSPQZe5m0xaY5mEtniI2EV7PCJkDUTAycNul1NM9UU2WwsQOBbileNQlniT
        D7pTcWwij7MgWh88Gnlu/mvoU+j5Bi8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-H0bJdmAkMD2-xbGpKL4_Ag-1; Wed, 23 Oct 2019 05:21:09 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A54E80183D;
        Wed, 23 Oct 2019 09:21:08 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 016585C1B2;
        Wed, 23 Oct 2019 09:20:53 +0000 (UTC)
Subject: Re: [PATCH 1/3 v4] x86/kdump: always reserve the low 1MiB when the
 crashkernel option is specified
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, bhe@redhat.com, dyoung@redhat.com,
        jgross@suse.com, dhowells@redhat.com, Thomas.Lendacky@amd.com,
        ebiederm@xmission.com, vgoyal@redhat.com, kexec@lists.infradead.org
References: <20191017094347.20327-1-lijiang@redhat.com>
 <20191017094347.20327-2-lijiang@redhat.com> <20191022083015.GB31700@zn.tnic>
 <75648e8d-4ef7-0537-618e-e4a57f0d3b9b@redhat.com>
 <20191023074602.GB16060@zn.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <98c9f97d-de22-2041-d0a4-214542807706@redhat.com>
Date:   Wed, 23 Oct 2019 17:20:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191023074602.GB16060@zn.tnic>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: H0bJdmAkMD2-xbGpKL4_Ag-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2019=E5=B9=B410=E6=9C=8823=E6=97=A5 15:46, Borislav Petkov =E5=86=
=99=E9=81=93:
> On Wed, Oct 23, 2019 at 01:35:09PM +0800, lijiang wrote:
>> Would you mind if i improve this patch as follow? Thanks.
>=20
> Yap, looks good to me.
>=20
Thanks for your comment.

OK. I will post this one and the third patch in this series later.

Thanks.
Lianbo


> Thx.
>=20

