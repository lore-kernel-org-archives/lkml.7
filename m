Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A780CA9ECE
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 08:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5143A2080F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 08:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T5IKsVKE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfKAIig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 04:38:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40612 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726532AbfKAIig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 04:38:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572597514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=21twbiV/PeEJDyN0S23lLHMUxVN62Bhy7BfFSoazEu8=;
        b=T5IKsVKE2FkoPNANbKrdUtIVQJgvQdCTBtmrWkOSBewBNKl/d25I+C8QYtLZt95IT39Xju
        cOGaa/u+O0rRNWHtnerHLMA2Vu0QRDiDt9rgIFmNU6l1ftgZnk7/bX8MlCNcjwfpDEGckg
        iIuio5fE/1Uh5tHRCqhqX6YYsBOZz20=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-WZmXbxdWN_6qGzae53I0vg-1; Fri, 01 Nov 2019 04:38:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BC91800EB2;
        Fri,  1 Nov 2019 08:38:26 +0000 (UTC)
Received: from krava (ovpn-204-176.brq.redhat.com [10.40.204.176])
        by smtp.corp.redhat.com (Postfix) with SMTP id 05EFD5D6A7;
        Fri,  1 Nov 2019 08:38:23 +0000 (UTC)
Date:   Fri, 1 Nov 2019 09:38:22 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org, eranian@google.com,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v3 3/7] perf evsel: Add iterator to iterate over events
 ordered by CPU
Message-ID: <20191101083822.GA4763@krava>
References: <20191025181417.10670-1-andi@firstfloor.org>
 <20191025181417.10670-4-andi@firstfloor.org>
 <20191030100606.GG20826@krava>
 <20191030155108.taqo2kbuaro3idhe@two.firstfloor.org>
 <20191030181552.GM20826@krava>
 <20191030190328.fhsv7e2fqqvfpsit@two.firstfloor.org>
MIME-Version: 1.0
In-Reply-To: <20191030190328.fhsv7e2fqqvfpsit@two.firstfloor.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: WZmXbxdWN_6qGzae53I0vg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 12:03:28PM -0700, Andi Kleen wrote:
> >=20
> > > The exists evlist->cpus cannot be used (I tried that)
> > > I also don't think we have an existing function to merge
> > > two maps, so that would need to be added to create it.
> > > Just using ->cpu_index is a much simpler change.
> >=20
> > I dont think that would be lot of code
> > and it would simplify this one
>=20
> AFAIK they're not guaranteed to be sorted, which makes merging
> complicated. I'm not sure it's safe to just sort existing maps
> because someone might have a index.

we could add bitmap to maps, then combining them
would be just a matter of or-ing them

>=20
> So you'll need to create temporary maps, sort them and then=20
> merge. Won't be simple.

it's also not simple to read simple event close code now

jirka

