Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6900BC04AB4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 20:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 383CB2084E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 20:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuLdLiNI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfEKUCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 16:02:45 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33712 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfEKUCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 16:02:44 -0400
Received: by mail-qt1-f195.google.com with SMTP id m32so7491577qtf.0;
        Sat, 11 May 2019 13:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lswjGdiyj2dRYacSr6F7O5W7w6MrJgdYsNd/5b6rmjQ=;
        b=VuLdLiNIFkIfbhT68czo43pudFcyaU4bnCZarpCQHY1v/kMt1GjtvdZ6R+ZJx3XzK7
         2zZjDDlc98id1xfs+XXwqIDGWJwWE6CxK/8/C7HjWf0om9ESKKkE9R6ZIHUrgvXblaEH
         QwvHkeFr9CDGSKS/d9ITpmvDjJnVRd2RJFwCQIoh5+AxVjFXsv71c4bHxJPn5RPz/8p4
         kKmDdn5rSJ6Wfd3MTLy4kLduTbP5vwcrkil+0CblPzC1cgyX1hVikkQ7aUC7CWXfVrWe
         luzjcc0gJT7WntXZDoYcHpTOwZU7SVka+RpEUDb5NtzV9WwJ3zajLDq/2U5Tyb/hyFpH
         D+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lswjGdiyj2dRYacSr6F7O5W7w6MrJgdYsNd/5b6rmjQ=;
        b=JOORI3yOttWfsAEuCJ6VfodynqG+X0ben6YIVBPNWpr8ZR9eijmXABjX08ffh8axQZ
         n6JTSXHb51/7oZaEBszXsOfmANdrq+JeCDZX7in8R5ZAlEFoRrI8fwHmxIo9ICbbsJ5X
         592O34ilbEPYL+DBP0uoGvcou42QT9TMBkE3Hp5fnBwhJeXm64I46YnH3DoQsXa5x30y
         p0SpjZy6KAe1wIKWoEhWrb+Czk/0+JlQpQy7W0cJJi4OHx3sRA8pl95OtRk2pRcR3iDR
         eErrAK/L3FfoPAF2nFHxKbvA1Sn8fLeWj0T/dVO053RX4wzZjto2dL62yNFSlPm4D57G
         p0EA==
X-Gm-Message-State: APjAAAVN28q+Nd/z8WiI3mxX2lbcZLmpqTPOzJF6eHlsJ8s7owuBDNbl
        6oukMx+NjKxyUkCmdaWypJw=
X-Google-Smtp-Source: APXvYqxVdYA4tW955Zbn2lnEeNVqbxQGjc1G4Y5NCP9sl0MmzM3MqNdU45CcS6K6kIUwPbQJCEG0jA==
X-Received: by 2002:ac8:38e1:: with SMTP id g30mr16293087qtc.108.1557604963300;
        Sat, 11 May 2019 13:02:43 -0700 (PDT)
Received: from gmail.com (pool-74-104-133-20.bstnma.fios.verizon.net. [74.104.133.20])
        by smtp.gmail.com with ESMTPSA id r47sm6938872qtc.14.2019.05.11.13.02.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 11 May 2019 13:02:42 -0700 (PDT)
Date:   Sat, 11 May 2019 16:02:35 -0400
From:   Sowmini Varadhan <sowmini05@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        David Miller <davem@davemloft.net>,
        Doug Ledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Subject: Re: Annoying gcc / rdma / networking warnings
Message-ID: <20190511200235.GA257@gmail.com>
References: <CAHk-=whbuwm5FbkPSfftZ3oHMWw43ZNFXqvW1b6KFMEj5wBipA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whbuwm5FbkPSfftZ3oHMWw43ZNFXqvW1b6KFMEj5wBipA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (05/11/19 12:52), Linus Torvalds wrote:
> 
> So David, arguably the kernel "struct sockaddr" is simply wrong, if it
> can't contain a "struct sockaddr_in6". No? Is extending it a huge
> problem for other users that don't need it (mainly stack, I assume..)?

The ipv6 working group came up with sockaddr_storage to solve this.
See RFC 2553. However, in practice, since sizeof(struct sockaddr_storage)
is much larger than simply creating a union of sockaddr_in and sockaaddr_in6,
most userspace networking applications will do the latter.

The strucut sockaddr is the mereely the generic pointer cast
that is expected to be used for the common posix fucntions like
bind/connect etc.

> Also equally arguably, the rdma code could just use a "struct
> sockaddr_in6 for this use and avoid the gcc issue, couldn't it? It has

Yes, that would be the right solution.

--Sowmini

