Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB2BCA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 17:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 788772087E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 17:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dVDrUgZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfJ3R3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 13:29:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40208 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726488AbfJ3R3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 13:29:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572456569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zA6i4fJUFRWIbj335/B8QHiHn0dUPzjeEPZBp4eEnG8=;
        b=dVDrUgZFGoM4MPbcTAMBmeyp0nxeJS5y8C11wK1PwFuO3vr3Nij1fx57v+BGYS34FEN5rN
        1fdptVWNSyoAkR6Zj5/j8b7ROiQ/j0wphRYf744n9chGk8V1CEASAAEAl7NEssm4/8FFIA
        Z7xw/G2lAJ4kE/GZuqxtqsGeJyi2WvU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-FwEAjuNyPbe-r_yj9282kA-1; Wed, 30 Oct 2019 13:29:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDEAF1005500;
        Wed, 30 Oct 2019 17:29:23 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6FA8B5D6D4;
        Wed, 30 Oct 2019 17:29:22 +0000 (UTC)
Date:   Wed, 30 Oct 2019 13:29:20 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v4 00/10] sched/fair: rework the CFS load balance
Message-ID: <20191030172920.GH1686@pauld.bos.csb>
References: <20191024123844.GB2708@pauld.bos.csb>
 <20191024134650.GD2708@pauld.bos.csb>
 <CAKfTPtB0VruWXq+wGgvNOMFJvvZQiZyi2AgBoJP3Uaeduu2Lqg@mail.gmail.com>
 <20191025133325.GA2421@pauld.bos.csb>
 <CAKfTPtDWV7AkzMNuJtkN-pLmDcK41LwNiX0Wr8UT+vMFHAx6Qg@mail.gmail.com>
 <20191030143937.GC1686@pauld.bos.csb>
 <564ca629-5c34-dbd1-8e64-2da6910b18a3@arm.com>
 <bf96be8a-2358-b9ab-b8eb-d0b8b94ed0d7@arm.com>
 <20191030171914.GF1686@pauld.bos.csb>
 <4c52d81f-4b3b-d7e8-c124-b90b4584a6d3@arm.com>
MIME-Version: 1.0
In-Reply-To: <4c52d81f-4b3b-d7e8-c124-b90b4584a6d3@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: FwEAjuNyPbe-r_yj9282kA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 06:25:09PM +0100 Valentin Schneider wrote:
> On 30/10/2019 18:19, Phil Auld wrote:
> >> Well from the code nobody but us (asymmetric capacity systems) set
> >> SD_BALANCE_WAKE. I was however curious if there were some folks who se=
t it
> >> with out of tree code for some reason.
> >>
> >> As Dietmar said, not having SD_BALANCE_WAKE means you'll never go thro=
ugh
> >> the slow path on wakeups, because there is no domain with SD_BALANCE_W=
AKE for
> >> the domain loop to find. Depending on your topology you most likely wi=
ll
> >> go through it on fork or exec though.
> >>
> >> IOW wake_wide() is not really widening the wakeup scan on wakeups usin=
g
> >> mainline topology code (disregarding asymmetric capacity systems), whi=
ch
> >> sounds a bit... off.
> >=20
> > Thanks. It's not currently set. I'll set it and re-run to see if it mak=
es
> > a difference.=20
> >=20
>=20
> Note that it might do more harm than good, it's not set in the default
> topology because it's too aggressive, see=20
>=20
>   182a85f8a119 ("sched: Disable wakeup balancing")
>=20

Heh, yeah... even as it's running I can see that this killing it :)


> >=20
> > However, I'm not sure why it would be making a difference for only the =
cgroup
> > case. If this is causing issues I'd expect it to effect both runs.=20
> >=20
> > In general I think these threads want to wake up the last cpu they were=
 on.
> > And given there are fewer cpu bound tasks that CPUs that wake cpu shoul=
d,
> > more often than not, be idle.=20
> >=20
> >=20
> > Cheers,
> > Phil
> >=20
> >=20
> >=20

--=20

