Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B168C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BD6420659
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xge9dF4Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfKUPNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 10:13:45 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58205 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726293AbfKUPNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 10:13:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574349224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J9pzKrfd3gSA7b3Gm7deCK2+P1QDiqTdKw/nLYXO50E=;
        b=Xge9dF4QyCsF7V3cdtx4YDPCvr7buUH3wJiygGG4TugE0AWMCTOlshu0YcEYE/J3gsWVvp
        ejCB8ISjEFmoUDiwsjsA/BZt+upEacPqNHKTF1vGfrJJaxUqSzmlrBoSVbamnSHHHuazQS
        T4FPQnvrqXufZpjWEXhoQnZIx70PVO8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-3yZsFvRzOq-8Io2RG1_QWQ-1; Thu, 21 Nov 2019 10:13:42 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C89AD8018A3;
        Thu, 21 Nov 2019 15:13:40 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8C01066839;
        Thu, 21 Nov 2019 15:13:39 +0000 (UTC)
Date:   Thu, 21 Nov 2019 16:13:38 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Andi Kleen <andi@firstfloor.org>, acme@kernel.org,
        jolsa@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 09/12] perf stat: Use affinity for opening events
Message-ID: <20191121151338.GC811@krava>
References: <20191116055229.62002-1-andi@firstfloor.org>
 <20191116055229.62002-10-andi@firstfloor.org>
 <20191120150732.GE4007@krava>
 <20191120223101.GB84886@tassilo.jf.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191120223101.GB84886@tassilo.jf.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 3yZsFvRzOq-8Io2RG1_QWQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 02:31:01PM -0800, Andi Kleen wrote:
> > > +=09=09evlist__for_each_cpu (evsel_list, i, cpu) {
> > > +=09=09=09affinity__set(&affinity, cpu);
> > > +=09=09=09/* First close errored or weak retry */
> > > +=09=09=09evlist__for_each_entry(evsel_list, counter) {
> > > +=09=09=09=09if (!counter->reset_group && !counter->errored)
> > > +=09=09=09=09=09continue;
> > > +=09=09=09=09if (evsel__cpu_iter_skip_no_inc(counter, cpu))
> > > +=09=09=09=09=09continue;
> > > +=09=09=09=09perf_evsel__close_cpu(&counter->core, counter->cpu_iter)=
;
> > > +=09=09=09}
> > > +=09=09=09/* Now reopen weak */
> > > +=09=09=09evlist__for_each_entry(evsel_list, counter) {
> > > +=09=09=09=09if (!counter->reset_group && !counter->errored)
> > > +=09=09=09=09=09continue;
> > > +=09=09=09=09if (evsel__cpu_iter_skip(counter, cpu))
> > > +=09=09=09=09=09continue;
> >=20
> > why staring at this I wonder why can't we call perf_evsel__close_cpu in
> > here and remove the above loop? together with evsel__cpu_iter_skip_no_i=
nc
> > function
>=20
> We only want to close events which errored or need a weak entry.
> The others can stay open.  perf_evsel__close_cpu closes all unconditional=
ly.

but the first loops checks fir !counter->errored, same as the second
one, so you could scratch the first loop and move perf_evsel__close_cpu
in the second one

jirka

