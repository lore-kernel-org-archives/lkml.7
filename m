Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C46DC5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B8F217F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qdew3CQo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390000AbfKEPy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 10:54:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40790 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389571AbfKEPy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 10:54:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572969265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lBJK8xKzWTLoxZq+hjJ5V27RUipKZggRLn9sGq9znSg=;
        b=Qdew3CQo5EkWekU9g5jjE92qA2NYbJfbbLCTGFKuHpg3izpcSyBZbl+TjzvjNnJ49iz9Qa
        YgzeTap2ohUbboR5hylIzU1o0xsOnMQY8qCWYr/g7TeNb1nycGpd/YgvuWTXGx5KM4CLs0
        q4W6c7YYl39znLpPRCOcd285GwV3zJk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-uSxGkBi8PyWQ5OqXVxSb7w-1; Tue, 05 Nov 2019 10:54:21 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B76A1005500;
        Tue,  5 Nov 2019 15:54:19 +0000 (UTC)
Received: from redhat.com (ovpn-118-16.phx2.redhat.com [10.3.118.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B21625D6A3;
        Tue,  5 Nov 2019 15:54:17 +0000 (UTC)
Date:   Tue, 5 Nov 2019 10:54:15 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jan Kara <jack@suse.cz>,
        Mel Gorman <mgorman@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RFC] mm: gup: add helper page_try_gup_pin(page)
Message-ID: <20191105155415.GA3142@redhat.com>
References: <20191103112113.8256-1-hdanton@sina.com>
 <20191104043420.15648-1-hdanton@sina.com>
 <20191104102050.15988-1-hdanton@sina.com>
 <20191105042755.7292-1-hdanton@sina.com>
MIME-Version: 1.0
In-Reply-To: <20191105042755.7292-1-hdanton@sina.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: uSxGkBi8PyWQ5OqXVxSb7w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 12:27:55PM +0800, Hillf Danton wrote:
>=20
> On Mon, 4 Nov 2019 14:03:55 -0500 Jerome Glisse wrote:
> >=20
> > On Mon, Nov 04, 2019 at 06:20:50PM +0800, Hillf Danton wrote:
> > >
> > > On Sun, 3 Nov 2019 22:09:03 -0800 John Hubbard wrote:
> > > > On 11/3/19 8:34 PM, Hillf Danton wrote:
> > > > ...
> > > > >>
> > > > >> Well, as long as we're counting bits, I've taken 21 bits (!) to =
track
> > > > >> "gupers". :)  More accurately, I'm sharing 31 bits with get_page=
()...please
> > > > >
> > > > > Would you please specify the reasoning of tracking multiple guper=
s
> > > > > for a dirty page? Do you mean that it is all fine for guper-A to =
add
> > > > > changes to guper-B's data without warning and vice versa?
> > > >
> > > > It's generally OK to call get_user_pages() on a page more than once=
.
> > >
> > > Does this explain that it's generally OK to gup pin a page under
> > > writeback and then start DMA to it behind the flusher's back without
> > > warning?
> >=20
> > It can happens today, is it ok ... well no but we live in an imperfect
> > world. GUP have been abuse by few device driver over the years and thos=
e
> > never checked what it meant to use it so now we are left with existing
> > device driver that we can not break that do wrong thing.
>=20
> See your point :)
>=20
> > I personaly think that we should use bounce page for writeback so that
> > writeback can still happens if a page is GUPed.
>=20
> Gup can be prevented from falling foul of writeback IMHO if the page
> under writeback, gup pinned or not, remains stable until it is no
> longer dirty.
>=20
> For that stability, either we can check PageWriteback on gup pinning
> for instance as the RFC does or drivers can set a gup-pinned page
> dirty only after DMA and start no more DMA until it is clean again.
>=20
> As long as that stability is ensured writeback will no longer need to
> take care of gup pin, long-lived or transient.
>=20
> It seems unlike a request too strict to meet in practice wrt data
> corruption, and bounce page for writeback sounds promising. Does it
> need to do a memory copy?

Once driver has GUP it does not check and re-check the struct page
so there is no synchronization whatsoever after GUP happened. In
fact for some driver you can not synchronize anything once the device
has been program. Many devices are not just simple DMA engine you
can start and stop at will (network, GPUs, ...).

So once a page is GUP there is just noway to garanty its stability
hence the best thing we can do is snapshot it to a bounce page.

Cheers,
J=E9r=F4me

