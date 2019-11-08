Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B946BC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC45218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X15hz2uD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731527AbfKHLAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:00:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52968 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730144AbfKHLAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:00:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573210818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e8H+8EXr85qqkjVdGRl2HLHxMJbVl3CVYe6CFvSaJAE=;
        b=X15hz2uDXcpjsWykCrcB9iG3FZ0jGH4TlIE0iERfAFt/bxqIKUwKA1dBgQCqDb9wXff5+8
        hpylREb/kGLDSJMAkvaA0IM6IR+9yWMv6mCi4fi6lVGURvkiHnHXFgWpYs9anexxA6LKAQ
        GYqbSbne14yGyhj1NrLi7XuGu6cBIXg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-bbm9uvzMMWy6NBJx-Sh1OQ-1; Fri, 08 Nov 2019 06:00:12 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69FA71005500;
        Fri,  8 Nov 2019 11:00:11 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8723F5C290;
        Fri,  8 Nov 2019 11:00:10 +0000 (UTC)
Date:   Fri, 8 Nov 2019 12:00:09 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf tool: Provide an option to print perf_event_open
 args and return value
Message-ID: <20191108110009.GE18723@krava>
References: <20191108093024.27077-1-ravi.bangoria@linux.ibm.com>
 <20191108094128.28769-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20191108094128.28769-1-ravi.bangoria@linux.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: bbm9uvzMMWy6NBJx-Sh1OQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 03:11:28PM +0530, Ravi Bangoria wrote:
> Perf record with verbose=3D2 already prints this information along with
> whole lot of other traces which requires lot of scrolling. Introduce
> an option to print only perf_event_open() arguments and return value.
>=20
> Sample o/p:
>   $ ./perf --debug perf-event-open=3D1 record -- ls > /dev/null
>   ------------------------------------------------------------
>   perf_event_attr:
>     size                             112
>     { sample_period, sample_freq }   4000
>     sample_type                      IP|TID|TIME|PERIOD
>     read_format                      ID
>     disabled                         1
>     inherit                          1
>     exclude_kernel                   1
>     mmap                             1
>     comm                             1
>     freq                             1
>     enable_on_exec                   1
>     task                             1
>     precise_ip                       3
>     sample_id_all                    1
>     exclude_guest                    1
>     mmap2                            1
>     comm_exec                        1
>     ksymbol                          1
>     bpf_event                        1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid 4308  cpu 0  group_fd -1  flags 0x8 =3D 4
>   sys_perf_event_open: pid 4308  cpu 1  group_fd -1  flags 0x8 =3D 5
>   sys_perf_event_open: pid 4308  cpu 2  group_fd -1  flags 0x8 =3D 6
>   sys_perf_event_open: pid 4308  cpu 3  group_fd -1  flags 0x8 =3D 8
>   sys_perf_event_open: pid 4308  cpu 4  group_fd -1  flags 0x8 =3D 9
>   sys_perf_event_open: pid 4308  cpu 5  group_fd -1  flags 0x8 =3D 10
>   sys_perf_event_open: pid 4308  cpu 6  group_fd -1  flags 0x8 =3D 11
>   sys_perf_event_open: pid 4308  cpu 7  group_fd -1  flags 0x8 =3D 12
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             1
>     size                             112
>     config                           0x9
>     watermark                        1
>     sample_id_all                    1
>     bpf_event                        1
>     { wakeup_events, wakeup_watermark } 1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
>   sys_perf_event_open failed, error -13
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.002 MB perf.data (9 samples) ]
>=20
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
> v1->v2:
>  - man page updates.

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

