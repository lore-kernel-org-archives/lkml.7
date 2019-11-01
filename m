Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5F1CA9ECE
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 08:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31865217D9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 08:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T2RLrf9y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbfKAIep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 04:34:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20270 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726964AbfKAIeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 04:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572597283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VeTVVRHH5RhLf1wEcfrwLCrIZRBQRtnalW9KKdhHWCI=;
        b=T2RLrf9yusTIu/oSDxl3Dbr9xzEOccK+As97rgynT1VUNaelsg09FfGVOsLEYbgCZgdfza
        cluP4JrrqZkjZRi+aATegEybevgPfN7/vMbaNu/GE7s3x6Ff4nrmEciY/kHMAy80/ESN2U
        6lYOMMR0o6XRoQaffwCl5gF/XE6V/mU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-XeYdMJPzMl-JuLS3R5yRzA-1; Fri, 01 Nov 2019 04:34:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4BC1800D49;
        Fri,  1 Nov 2019 08:34:38 +0000 (UTC)
Received: from krava (ovpn-204-176.brq.redhat.com [10.40.204.176])
        by smtp.corp.redhat.com (Postfix) with SMTP id D580360852;
        Fri,  1 Nov 2019 08:34:35 +0000 (UTC)
Date:   Fri, 1 Nov 2019 09:34:34 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v5 7/7] perf report: Sort by sampled cycles percent per
 block for tui
Message-ID: <20191101083434.GD2172@krava>
References: <20191030060430.23558-1-yao.jin@linux.intel.com>
 <20191030060430.23558-8-yao.jin@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191030060430.23558-8-yao.jin@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: XeYdMJPzMl-JuLS3R5yRzA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 02:04:30PM +0800, Jin Yao wrote:

SNIP

> diff --git a/tools/perf/ui/browsers/hists.h b/tools/perf/ui/browsers/hist=
s.h
> index 91d3e18b50aa..078f2f2c7abd 100644
> --- a/tools/perf/ui/browsers/hists.h
> +++ b/tools/perf/ui/browsers/hists.h
> @@ -5,6 +5,7 @@
>  #include "ui/browser.h"
> =20
>  struct annotation_options;
> +struct evsel;
> =20
>  struct hist_browser {
>  =09struct ui_browser   b;
> @@ -15,6 +16,7 @@ struct hist_browser {
>  =09struct pstack=09    *pstack;
>  =09struct perf_env=09    *env;
>  =09struct annotation_options *annotation_opts;
> +=09struct evsel=09    *block_evsel;

you should be able to get the evsel from hists_to_evsel function

jirka

