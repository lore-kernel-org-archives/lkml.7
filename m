Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E70C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4CC72133D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XRELgRpc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfCSOio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:38:44 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39410 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfCSOin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:38:43 -0400
Received: by mail-io1-f66.google.com with SMTP id e13so7786659ioq.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 07:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7U+OTIIdWnCov6mSraadUfkAw2secBf1APCOplQxL94=;
        b=XRELgRpcW8PByrSutifGNQYcR6UVobnjl5KctbwlWR2qqbx/tOPIgag5tMMWADDnhW
         1W8IOQnCI31OxiRK+5OkKCjiC9T5T15+1hubhiOBG+QOWp+ZJ1QrjpiO4pO3C5pnywOR
         sCG2FhV5Y5NZpyORDCN3eLdpXI+9RGx0u2iAHFuU9t6byV3Tpj5wmCNzhwYADxBqJB4m
         1fl89A0ewjx48HjOP/e5YwPyD07aYjaLGrfXVN57LPhPkou71d0piG1Kzqk6ahpzeDjJ
         E3PKU8MtJzWdMU6b1mp5vlIDtzsz93TXnL5kGncZDbXRwD2nM9nDJFMJQz8aZXx9pNDP
         5b2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7U+OTIIdWnCov6mSraadUfkAw2secBf1APCOplQxL94=;
        b=puRCZ/tnvrE0jCTZVSOr/1f8aRMnd2jX9BhU7CxGWVvtlqk2oGuqP2bU7CY4BToDZQ
         kG+5zkP4bypkUMr5tVn+LBoSN/lu9zu0ipvjYVC1/K5aPTDR6wPACOtaQ5WJ49A996zV
         KeZJQ1bkwOfxrL4Thym4usDrBXpkENqOozYioGBv0AaSU21/cgyi2RDF7HXDd3wTjkTT
         0qAwyUoA5ADnQUGXDUmOSfGuEsOTAa7mZrFxF1Et8EcjI8seWFkVygIm/jsZiRk5CiRX
         XSKiMefSdRIpMyhDl/vD2nNjLX1Hg76YRoArb2YhhyqG+JWJ1kUqp+7dDIauzUM2kuP+
         eOhw==
X-Gm-Message-State: APjAAAWDdE0Im4WGLN+XHu6PbU9fpHYU+sJNWp1zffEj/1I6bdx3UVUu
        Mxbe13I9jC59/SYQiIxxFPtfrH7FvPOcCKY7hBTCcw==
X-Google-Smtp-Source: APXvYqyY83V62WrHkto4UDsuc9so3fmaBovZbKrPZqFQgI+GspR8tfbe9PVzljL9UEzgbvlg5S8KS25Vf8LW+3TCp8M=
X-Received: by 2002:a5e:d608:: with SMTP id w8mr1679711iom.293.1553006323165;
 Tue, 19 Mar 2019 07:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190315022649.17848-1-yuehaibing@huawei.com> <20190318171518.GH22548@kernel.org>
In-Reply-To: <20190318171518.GH22548@kernel.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 19 Mar 2019 08:38:32 -0600
Message-ID: <CANLsYkzU25wAx0dMQqMVZ2asx+z-taOfffLO7DMd6mkDXc7D9A@mail.gmail.com>
Subject: Re: [PATCH] perf tools: return errcode in cs_etm__process_auxtrace_info
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Yue Haibing <yuehaibing@huawei.com>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2019 at 11:15, Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Fri, Mar 15, 2019 at 10:26:49AM +0800, Yue Haibing escreveu:
> > From: YueHaibing <yuehaibing@huawei.com>
> >
> > 'err' is set in err path, but it's not returned to callers.
> > Also fix a pass zero to PTR_ERR issue.
>
> Next time please submit two patches, one for the PTR_ERR and another for
> not throwing away the err = -E!INVAL and returning just -EINVAL, I'm
> doing it this time.
>

Please hold off on that - I've asked for other modifications to be
done on this patch.

Mathieu

>  - Arnaldo
>
> > Fixes: cd8bfd8c973e ("perf tools: Add processing of coresight metadata")
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> >  tools/perf/util/cs-etm.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index 1108049..111f33c 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -1908,7 +1908,7 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
> >
> >               /* Something went wrong, no need to continue */
> >               if (!inode) {
> > -                     err = PTR_ERR(inode);
> > +                     err = -ENOMEM;
> >                       goto err_free_metadata;
> >               }
> >
> > @@ -2023,5 +2023,5 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
> >  err_free_hdr:
> >       zfree(&hdr);
> >
> > -     return -EINVAL;
> > +     return err;
> >  }
> > --
> > 2.7.0
> >
>
> --
>
> - Arnaldo
