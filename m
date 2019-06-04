Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B11FC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 19:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 172722075B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 19:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZWkTsPMz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfFDThO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 15:37:14 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40229 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfFDThO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 15:37:14 -0400
Received: by mail-pl1-f196.google.com with SMTP id g69so8743218plb.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 12:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:from:subject:user-agent:date;
        bh=wR7K6rwo4Jf2/AFMZkaXDQN87jKfQ96qQ877W6vcmgc=;
        b=ZWkTsPMzXzKaNC9jV4BMIaQAFzkFVB8W3nMso6N1+u6RRZU361q9SzN3hhaamFaj2S
         3FDqL7nnOPRiiOCMeWeg3uelWuIlruaQIHjSSZJBs1thMX54ug2zKZ57AfZyY4FGVBnC
         3GibHDBOiL4ZD2EFcTuR2+80tm+CoOayxGfD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:date;
        bh=wR7K6rwo4Jf2/AFMZkaXDQN87jKfQ96qQ877W6vcmgc=;
        b=grtahwRiKSBh6qMX2zprEa52s1IHAzQJ5zpX900/3eUmSNec/4F3IA7svKKC7BmYlN
         33E/7EE9jI/C+P+foMd1m+VjnR4oSce0VIipN1wfDAAiwVMFAXiXk6bLCyXGaBp4Zc2d
         n6zZ+SDnaHrx1xE4jHFb55KjGzjIuMrWx/YrKE3N7fzCpaiu22L9ZtwWCTetFO2OzrMV
         zlfMhHRBFL/gHauGNw01n1ikSMYYAACL5agVCUz2qCHMNol4MLKxuBNCpyNJsw5sb1yH
         JnILmDuTjc5HvXhgYP8SX6bknWom4CtdDDTdjArd+S9uvUWad6ZTbbF/MQuVSmWZeGvg
         H5iQ==
X-Gm-Message-State: APjAAAU1e8xJ3QVWLQTWo+o68VpS0iiib3VxNnr9TfMEt6VZFS+8W7Cv
        vm14ze5y/oHSdw2f6OWcd2ldFg==
X-Google-Smtp-Source: APXvYqx/XG7jtVZN3IlWga1sbgAvrTvaf61q+rbJEyovi1zKQb0wfhhWaC0ana2hJwlp7SyRImh+FQ==
X-Received: by 2002:a17:902:d715:: with SMTP id w21mr38874215ply.234.1559677033534;
        Tue, 04 Jun 2019 12:37:13 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 128sm20136240pff.16.2019.06.04.12.37.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Jun 2019 12:37:13 -0700 (PDT)
Message-ID: <5cf6c869.1c69fb81.5ed2e.84d1@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190604182719.15944-1-helen.koike@collabora.com>
References: <20190604182719.15944-1-helen.koike@collabora.com>
Cc:     wad@chromium.org, keescook@chromium.org, snitzer@redhat.com,
        linux-doc@vger.kernel.org, richard.weinberger@gmail.com,
        linux-kernel@vger.kernel.org, linux-lvm@redhat.com,
        enric.balletbo@collabora.com, kernel@collabora.com, agk@redhat.com,
        Helen Koike <helen.koike@collabora.com>,
        Jonathan Corbet <corbet@lwn.net>
To:     Helen Koike <helen.koike@collabora.com>, dm-devel@redhat.com
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] Documentation/dm-init: fix multi device example
User-Agent: alot/0.8.1
Date:   Tue, 04 Jun 2019 12:37:12 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Helen Koike (2019-06-04 11:27:19)
> The example in the docs regarding multiple device-mappers is invalid (it
> has a wrong number of arguments), it's a left over from previous
> versions of the patch.
> Replace the example with an valid and tested one.
>=20
> Signed-off-by: Helen Koike <helen.koike@collabora.com>
>=20
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

