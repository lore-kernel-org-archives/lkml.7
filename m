Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C63CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85ED320663
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RTdK4SUY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404555AbfJWKmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 06:42:55 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32927 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390181AbfJWKmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 06:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571827374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u2SunQ8Ras1PaEhj4x41QNcvtS5kNNCH7BoY7fCECxY=;
        b=RTdK4SUYSCgmmYLDRq7WKtTNgIkq/661hZ3ASNJm9zcRFrgOR9AmiYAM3hQfsYP5plVd2y
        sAOzA0GmIYHYdVdLqhX+8Px152Ej8cDOOFOaKF9vQnC46XbQKWAge3TEfeG6dSRgK7moHR
        uEq0RtLyflJ7y+75jg8ZmXn1CsUtxtQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-hhKhSfenMsyIkiZzHNzePw-1; Wed, 23 Oct 2019 06:42:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE339107AD33;
        Wed, 23 Oct 2019 10:42:48 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id DE2205D6C8;
        Wed, 23 Oct 2019 10:42:46 +0000 (UTC)
Date:   Wed, 23 Oct 2019 12:42:45 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Igor Lubashev <ilubashe@akamai.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] perf kvm: Allow running without stdin
Message-ID: <20191023104245.GL22919@krava>
References: <1571795693-23558-1-git-send-email-ilubashe@akamai.com>
 <1571795693-23558-3-git-send-email-ilubashe@akamai.com>
MIME-Version: 1.0
In-Reply-To: <1571795693-23558-3-git-send-email-ilubashe@akamai.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: hhKhSfenMsyIkiZzHNzePw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 09:54:52PM -0400, Igor Lubashev wrote:
> Allow perf kvm --stdio to run without access to stdin.
> This lets perf kvm to run in a batch mode until interrupted.
>=20
> The following now works as expected:
>=20
>   $ perf kvm top --stdio < /dev/null
>=20
> Signed-off-by: Igor Lubashev <ilubashe@akamai.com>
> ---
>  tools/perf/builtin-kvm.c | 33 ++++++++++++++++++++-------------
>  1 file changed, 20 insertions(+), 13 deletions(-)
>=20
> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> index 858da896b518..5217aa3596c7 100644
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c
> @@ -930,18 +930,20 @@ static int fd_set_nonblock(int fd)
> =20
>  static int perf_kvm__handle_stdin(void)
>  {
> -=09int c;
> -
> -=09c =3D getc(stdin);
> -=09if (c =3D=3D 'q')
> +=09switch (getc(stdin)) {
> +=09case 'q':
> +=09=09done =3D 1;
>  =09=09return 1;
> -
> -=09return 0;
> +=09case EOF:
> +=09=09return 0;
> +=09default:
> +=09=09return 1;
> +=09}
>  }
> =20
>  static int kvm_events_live_report(struct perf_kvm_stat *kvm)
>  {
> -=09int nr_stdin, ret, err =3D -EINVAL;
> +=09int nr_stdin =3D -1, ret, err =3D -EINVAL;
>  =09struct termios save;
> =20
>  =09/* live flag must be set first */
> @@ -972,13 +974,16 @@ static int kvm_events_live_report(struct perf_kvm_s=
tat *kvm)
>  =09if (evlist__add_pollfd(kvm->evlist, kvm->timerfd) < 0)
>  =09=09goto out;
> =20
> -=09nr_stdin =3D evlist__add_pollfd(kvm->evlist, fileno(stdin));
> -=09if (nr_stdin < 0)
> -=09=09goto out;
> -
>  =09if (fd_set_nonblock(fileno(stdin)) !=3D 0)
>  =09=09goto out;
> =20
> +=09/* add stdin, if it is connected */
> +=09if (getc(stdin) !=3D EOF) {
> +=09=09nr_stdin =3D evlist__add_pollfd(kvm->evlist, fileno(stdin));
> +=09=09if (nr_stdin < 0)
> +=09=09=09goto out;
> +=09}
> +
>  =09/* everything is good - enable the events and process */
>  =09evlist__enable(kvm->evlist);
> =20
> @@ -994,8 +999,10 @@ static int kvm_events_live_report(struct perf_kvm_st=
at *kvm)
>  =09=09if (err)
>  =09=09=09goto out;
> =20
> -=09=09if (fda->entries[nr_stdin].revents & POLLIN)
> -=09=09=09done =3D perf_kvm__handle_stdin();
> +=09=09if (nr_stdin >=3D 0 && fda->entries[nr_stdin].revents & POLLIN) {
> +=09=09=09if (!perf_kvm__handle_stdin())

can this return 0 ? if stdin is EOF then nr_stdin stays -1

> +=09=09=09=09fda->entries[nr_stdin].events =3D 0;

why do you need to set events to 0 in here?

thanks,
jirka

