Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AD2C5B577
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDDB4208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="lzNeIxjh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfF0W5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 18:57:18 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41008 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfF0W5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 18:57:18 -0400
Received: by mail-oi1-f193.google.com with SMTP id g7so2830789oia.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 15:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=scI9xH5QTIptTJudFoOALtkbeV4cljG3jybWqqwH29M=;
        b=lzNeIxjhGX5LiRIdNnCz242+TWgFtnYUcwfRc66LhW+zqc2cWbPYRyv9JLV7LLz2L8
         a7GMdfELV4pXkrVqRQ20l7nuoIr4S+GFQaHtfw9glxPJ9RWhI0W4G9FBPo8mlqQk3wqu
         u5mZVfHTVbUokMdQZLqAqeNklj9ZNOcj613+6njKSKX0pBADLToDIKB+gq/8p02uUt/7
         ouv8vDuhLw17mG4tjvvRhIZ3jXZPNc3aePVsSLW218VBzp4hwt/YjwRajPd/t3ySeryo
         NnmwR9zT6JwqTGZRGcdpgSSQP9/8FDI2ci5AlXXucZb8CGXA+4MoHBNPVgnMbVRNdwfd
         T9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=scI9xH5QTIptTJudFoOALtkbeV4cljG3jybWqqwH29M=;
        b=OCMGCA01oTxveX/w5tuBoERb5nm3ontwHW+VOUAkOuHb0NR053ujX90Qm1JxmCHPSW
         iduuZcoEYAdV/agTVIMXwrqx87wMBr76R/rH21DgF9ACYLLkwbomVB4U73sWZcv+EeS0
         pgPbDyKIZopl9KFYAe6yRC+4AYwGdkW6a5V6rqEUZmwdqH3newiAk98BXA4VLfa9D+xI
         ZR+rokwueQX9OFdb5E7cO2kCnOzEoAVVyEnq9siMrAOGpBcAyT4DtKendvbvASsq8x+4
         HY9Rcze1QrTkXXC534Mzhluu+QNdIltyEHTPKx0dqJxyD3VWgo5NkyZY04/Ox5Wjlu+b
         49kA==
X-Gm-Message-State: APjAAAVhbti0ohbxca9/1abMHOoQ4wbPM05qP9oBYRXt2I8K9u3lGPN0
        Zbbt2RC9+jdQx1J7PW2UT6hU+RoGiI3QHdNC4irycw==
X-Google-Smtp-Source: APXvYqyy2rBxOKQF++zFTIccWwiLuYTSQZp4Yq6Lngm6GFhvxmoRuZ+7vmMtS6tCXZo+fDx9Jp0Z36Kry44jWnNxlxQ=
X-Received: by 2002:aca:af55:: with SMTP id y82mr4917oie.172.1561676237533;
 Thu, 27 Jun 2019 15:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190626005449.225796-1-trong@android.com> <20190626011221.GB22454@kroah.com>
 <CANA+-vBoabFTD=fMz+0d5Sbe9rPwnxcuxJxaMCT3KAwXYHSD7w@mail.gmail.com>
 <CANA+-vD+qBqENZrk_7KZzedbzGPMzHniHTE4sY93gnkzzBif6A@mail.gmail.com> <20190627000412.GA527@kroah.com>
In-Reply-To: <20190627000412.GA527@kroah.com>
From:   Tri Vo <trong@android.com>
Date:   Thu, 27 Jun 2019 15:57:06 -0700
Message-ID: <CANA+-vBOQM=XXQx93o4ZPs7yaWyyAeHPds1NQbo5zYGGqVitMg@mail.gmail.com>
Subject: Re: [PATCH] PM / wakeup: show wakeup sources stats in sysfs
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 5:04 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jun 26, 2019 at 03:48:58PM -0700, Tri Vo wrote:
> > On Tue, Jun 25, 2019 at 6:33 PM Tri Vo <trong@android.com> wrote:
> > >
> > > On Tue, Jun 25, 2019 at 6:12 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Tue, Jun 25, 2019 at 05:54:49PM -0700, Tri Vo wrote:
> > > > > Embedding a struct kobject into struct wakeup_source changes lifetime
> > > > > requirements on the latter. To that end, change deallocation of struct
> > > > > wakeup_source using kfree to kobject_put().
> > > >
> > > > Ick, are you sure you need a new kobject here?  Why wouldn't a named
> > > > attribute group work instead?  That should keep this patch much smaller
> > > > and simpler.
> > >
> > > Yeah, named attribute groups might be a much cleaner way to do this.
> > > Let me investigate.
> >
> > Say, we read /sys/power/wakeup_sources/foo/active_count.
>
> What is "foo" here?  You didn't include Documentation of the sysfs
> files so it was pretty impossible to say what exactly your heirachy was
> going to be in order to determine this :)

Sorry about that. I sent out a new version of the patch with updated
documentation.
