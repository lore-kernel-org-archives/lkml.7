Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85071CA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 08:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 568F421734
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 08:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YfQBdPem"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730256AbfKAINM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 04:13:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29822 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729942AbfKAINL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 04:13:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572595990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9xs42rpsdkzt7bmetZPLlor3pgrYAufRSm92IKtSpJQ=;
        b=YfQBdPemN+dTJabPXbBaJiwSkU7JDmHPyNaKGQzgviM9FutEKrVWtud8tDADU48qDJFiLK
        P1DzZ2jINjqbfY/U4LHfJWC56p+gcR039ix754po01N0i5hTpYO8U8eUjBH6MuFJP2rSFT
        81mo7Ml60H2b4lTExykGg+kv0wAeEb0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-DkDlpLGBNjmA7Uq27Li0mQ-1; Fri, 01 Nov 2019 04:13:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4450800D49;
        Fri,  1 Nov 2019 08:13:05 +0000 (UTC)
Received: from krava (ovpn-204-176.brq.redhat.com [10.40.204.176])
        by smtp.corp.redhat.com (Postfix) with SMTP id C6F9D60870;
        Fri,  1 Nov 2019 08:13:01 +0000 (UTC)
Date:   Fri, 1 Nov 2019 09:13:00 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     jsun4 <jiwei.sun@windriver.com>
Cc:     acme@redhat.com, arnaldo.melo@gmail.com,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        mpetlan@redhat.com, namhyung@kernel.org, a.p.zijlstra@chello.nl,
        adrian.hunter@intel.com, Richard.Danter@windriver.com,
        jiwei.sun.bj@qq.com
Subject: Re: [PATCH v5] perf record: Add support for limit perf output file
 size
Message-ID: <20191101081300.GA2172@krava>
References: <20191022080901.3841-1-jiwei.sun@windriver.com>
MIME-Version: 1.0
In-Reply-To: <20191022080901.3841-1-jiwei.sun@windriver.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: DkDlpLGBNjmA7Uq27Li0mQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 04:09:01PM +0800, jsun4 wrote:
> The patch adds a new option to limit the output file size, then based
> on it, we can create a wrapper of the perf command that uses the option
> to avoid exhausting the disk space by the unconscious user.
>=20
> In order to make the perf.data parsable, we just limit the sample data
> size, since the perf.data consists of many headers and sample data and
> other data, the actual size of the recorded file will bigger than the
> setting value.
>=20
> Testing it:
>=20
>  # ./perf record -a -g --max-size=3D10M
>  Couldn't synthesize bpf events.
>  [ perf record: perf size limit reached (10249 KB), stopping session ]
>  [ perf record: Woken up 32 times to write data ]
>  [ perf record: Captured and wrote 10.133 MB perf.data (71964 samples) ]
>=20
>  # ls -lh perf.data
>  -rw------- 1 root root 11M Oct 22 14:32 perf.data
>=20
>  # ./perf record -a -g --max-size=3D10K
>  [ perf record: perf size limit reached (10 KB), stopping session ]
>  Couldn't synthesize bpf events.
>  [ perf record: Woken up 0 times to write data ]
>  [ perf record: Captured and wrote 1.546 MB perf.data (69 samples) ]
>=20
>  # ls -l perf.data
>  -rw------- 1 root root 1626952 Oct 22 14:36 perf.data
>=20
> Signed-off-by: Jiwei Sun <jiwei.sun@windriver.com>
> ---
> v5 changes:
>   - Change the output format like [ perf record: perf size limit XX ]
>   - change the killing perf way from "raise(SIGTERM)" to set "done =3D=3D=
 1"

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

