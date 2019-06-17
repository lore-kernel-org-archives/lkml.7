Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EC7C31E5E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0635E2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560797435;
	bh=cysxPItUyhXKJdd7ElK6vDJrBN3A4m7kU/pDJDw4J2I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sdEZ1PrFm/jzo2LnLMkCgrYFSX6G+CwB2dFyVS0Srou1HS9Tl7a65nD1SDS+tqnqn
	 pX50Ag6uDOUzJVZkXlcldtyCSTya63htPOpUEIgIgdJptlpaFHaoVefxj1AqWaZmDF
	 I0T2ULphaXKD3egIXXXAC5Hbt+ZO3ARCDPLaNOMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfFQSue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 14:50:34 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40726 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbfFQSud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 14:50:33 -0400
Received: by mail-lf1-f67.google.com with SMTP id a9so7324231lff.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 11:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pJNgLRxBBn3ldusAk8vZnHSv/cw7OZUcPpU87Ds7axA=;
        b=Bou8DRGEQCecEBNSUfFtTPeseoLHD0XaAFEIBsWSO0ipikvw3uK03pajREfMRg9xGJ
         RHjbeoD4wiwvH1jw+HHfdArE6k8zcfMKGxTOigVfiqDD3yQNYZV/bHc7sTIEHfVYs6/a
         BFygJ9Og1NqRb3jOobPB1z9rLh9rBzkbN9K0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pJNgLRxBBn3ldusAk8vZnHSv/cw7OZUcPpU87Ds7axA=;
        b=p5cRLihHCdHBHSDaJoQ13Fw/+vtMPwvtf/gABUCRng5QQnEtoMTLAp2k/T38AVjoQn
         h6uQRivm1swl2Dp30woFNJ0lKPQqZ6Coa6WLaYQaKHIijYM3mDwG9/51VXXBq0BYUsk5
         8psL7tQ3wgCBxkn+ZQ4V4RgANkt8ZZtdYQXpC1wkSH1iIO+4a27uDG28l7eVUKtNXTaf
         FHScqw7mut044oDDK6QW5Ju2GjvS0iBs2W8Q1dJqaRT/0Ix7+Vi6Nziyjxmh8Uz3yK0P
         9TbMpnV3Lh4Qj9wXtiLDDo12J2Wf6d5Nl6EJihug4AZTcJVf0Ad4ujn71uW+8CVBF0BL
         6jMA==
X-Gm-Message-State: APjAAAWinUXzWNZdKCysERMeLgGbEQSEWL1ZokADETswND9cDk9lRbuE
        eMDgzvadR9gycF/H9J2d4x2KgtnR+5Q=
X-Google-Smtp-Source: APXvYqybFYlyqxRAHkcUrwtRg6hTlG+MsbUQiJMuzbPwhr7S/5FXxew5BWAgXvGv3XXR34sMfpXxIQ==
X-Received: by 2002:a19:9156:: with SMTP id y22mr10978398lfj.43.1560797430988;
        Mon, 17 Jun 2019 11:50:30 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id z85sm2213274ljb.101.2019.06.17.11.50.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 11:50:30 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id t28so10348861lje.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 11:50:30 -0700 (PDT)
X-Received: by 2002:a2e:9a58:: with SMTP id k24mr14840250ljj.165.1560797429770;
 Mon, 17 Jun 2019 11:50:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190617184711.21364-1-christian@brauner.io>
In-Reply-To: <20190617184711.21364-1-christian@brauner.io>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Jun 2019 11:50:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh+OWQ2s-NZC4RzfHtgNfhV9sbtP6dXV4WnsVRQ3A3hnA@mail.gmail.com>
Message-ID: <CAHk-=wh+OWQ2s-NZC4RzfHtgNfhV9sbtP6dXV4WnsVRQ3A3hnA@mail.gmail.com>
Subject: Re: [PATCH] fs/namespace: fix unprivileged mount propagation
To:     Christian Brauner <christian@brauner.io>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 11:47 AM Christian Brauner <christian@brauner.io> wrote:
>
> When propagating mounts across mount namespaces owned by different user
> namespaces it is not possible anymore to move or umount the mount in the
> less privileged mount namespace.

I will wait a short while in the hope of getting Al's ack for this,
but since it looks about as good as it likely can be, I suspect I'll
just apply it later today even without such an ack..

                    Linus
