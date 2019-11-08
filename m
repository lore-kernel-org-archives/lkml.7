Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43BCC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 08:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F02721D7B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 08:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CAx+o6gH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbfKHIEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 03:04:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26283 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725975AbfKHIEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 03:04:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573200286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qWW7lSksXKBe3gtmSaHmd1nhLn1ehC7ZJbxfI0NV0Fc=;
        b=CAx+o6gHnelcI6pwa2quirV+CBkQDhijX+S9iqloxma5Vq5Q5oO5QzePSGhSYFI7Ixj6bo
        eCiU+5vG8j8tCrbdsGlR4Yh0xnFL77rNNbCXo+kaQ20zQDQjjIIS2emJUhCuvH2zi9Nnwj
        JZrrtHIktEw8oJ+eYOvjTvXz2+IcV9I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-qM4yrXMLNl-S0fWBiusYxg-1; Fri, 08 Nov 2019 03:04:42 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E04F48017DE;
        Fri,  8 Nov 2019 08:04:41 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id 14CD71081304;
        Fri,  8 Nov 2019 08:04:40 +0000 (UTC)
Date:   Fri, 8 Nov 2019 09:04:40 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] perf record: Add option to print perf_event_open args and
 return value
Message-ID: <20191108080440.GB28919@krava>
References: <20191108035949.32644-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20191108035949.32644-1-ravi.bangoria@linux.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: qM4yrXMLNl-S0fWBiusYxg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 09:29:49AM +0530, Ravi Bangoria wrote:
> Perf record with verbose=3D2 already prints this information along with
> whole lot of other traces which requires lot of scrolling. I thought
> to show this information in verbose=3D1 but I fear that it will be too
> much for level 1. So finally created a new option specifically for
> printing this.
>=20
> Sample o/p:
>   $ ./perf record --peo-args -- ls > /dev/null
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

right, -vv is already poluted ;-) but we have the perf --debug
option for specific debug:

       --debug
           Setup debug variable (see list below) in value range (0, 10). Us=
e like: --debug verbose # sets verbose =3D 1 --debug verbose=3D2 # sets ver=
bose =3D 2

               List of debug variables allowed to set:
                 verbose          - general debug messages
                 ordered-events   - ordered events object debug messages
                 data-convert     - data convert command debug messages
                 stderr           - write debug output (option -v) to stder=
r
                                    in browser mode

so I think something like this would fit better:

  perf --debug event-open[=3DX] record ... =20
  perf --debug perf-event-open[=3DX] record ... =20

you can have different levels for specific debug output,
also it should also stay part of -vv output

thanks,
jirka

