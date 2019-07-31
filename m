Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A5FC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 23:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED8F208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 23:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZqOvaIKn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730544AbfGaXBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 19:01:00 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35899 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbfGaXBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 19:01:00 -0400
Received: by mail-qt1-f193.google.com with SMTP id z4so68316319qtc.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 16:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=his7K/u+JOrtxUOs2Ekh5bM+KWEwFmVBgmJqXbtUu9E=;
        b=ZqOvaIKn5gpXMKF0lFuPBJqJcfbMtb3MPGVVmN3aQsXXr9MSvDSwnBIoLdfs4Cduzu
         QRA8c1QAxNjNjf8z0l9WF9x2Kw8+F1laR/NQxc3pyjTGetdSmplJvdURFUqnq6fIi7Y5
         JS4Uvm5qizwTDtKpRb8KoH2QzFqssZQiMkXG494iOUBy1xVC1xhi6b5WNlWd0gIvaub2
         W1XaQLBaV1YKYGli71I0JUa9mD2l2THlCEAFuHc01L/n1KcqIaj1oCEo7xdECmJqx39w
         8DGqiJA1GV5ZIbSfFrgl6Pwwxp6UZXG3UZ0N0Nuntbj6x+BE/tlQ9FyXqpoxRRJYgrFQ
         ADTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=his7K/u+JOrtxUOs2Ekh5bM+KWEwFmVBgmJqXbtUu9E=;
        b=NS4F1b04pvoOoyNn3xB9HIONrLxai055mrlZGNYBiFFcOrnprR7W8IQMLoB0G+pcu0
         NqhrXTm2jLWMnYKQ0EyPS8s0fRQslBWwC+Cd6rMkNBZjlz6dVOjRJskF4psdNWXtoGgi
         HJ/hjGJJUBsSbeHOeZ935udPb/RRN1rgI0j98vVvMgRU2XMIIGc94a8GsAsr1hdmP/GT
         0KmnDzszz1Mfo3GRwlY3tF93v2O4k6VWxchtSdAHLb/2sW8jaRElQJZQDExqj15+dVRs
         gYlqzgwxeHR+EijeJlB1Frf9EXKnSmde7l80AZKc69YoqXwcFGTtehnyB2p7nRp9xM5A
         X9/Q==
X-Gm-Message-State: APjAAAXSCErzRtcxHS8ggEbaod9fo8iyA8iQ+ACJPbgiBMYP80ms81i6
        WjX4C2ZEbV2215gpgH4FOlvX3A==
X-Google-Smtp-Source: APXvYqwJPf0PqUhqgGpVR2IzxGvlfGykM1M7nRsba5YS0Ne3y5wjASuoEvOh6D7uIAmXvcUuYYR1nQ==
X-Received: by 2002:ac8:688:: with SMTP id f8mr11797584qth.130.1564614059446;
        Wed, 31 Jul 2019 16:00:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id n18sm29218512qtr.28.2019.07.31.16.00.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Jul 2019 16:00:58 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hsxab-00009Y-B9; Wed, 31 Jul 2019 20:00:57 -0300
Date:   Wed, 31 Jul 2019 20:00:57 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        syzbot <syzbot+e58112d71f77113ddb7b@syzkaller.appspotmail.com>,
        aarcange@redhat.com, akpm@linux-foundation.org,
        christian@brauner.io, davem@davemloft.net, ebiederm@xmission.com,
        elena.reshetova@intel.com, guro@fb.com, hch@infradead.org,
        james.bottomley@hansenpartnership.com, jglisse@redhat.com,
        keescook@chromium.org, ldv@altlinux.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-parisc@vger.kernel.org,
        luto@amacapital.net, mhocko@suse.com, mingo@kernel.org,
        namit@vmware.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        wad@chromium.org
Subject: Re: WARNING in __mmdrop
Message-ID: <20190731230057.GA32346@ziepe.ca>
References: <ada10dc9-6cab-e189-5289-6f9d3ff8fed2@redhat.com>
 <aaefa93e-a0de-1c55-feb0-509c87aae1f3@redhat.com>
 <20190726094756-mutt-send-email-mst@kernel.org>
 <0792ee09-b4b7-673c-2251-e5e0ce0fbe32@redhat.com>
 <20190729045127-mutt-send-email-mst@kernel.org>
 <4d43c094-44ed-dbac-b863-48fc3d754378@redhat.com>
 <20190729104028-mutt-send-email-mst@kernel.org>
 <96b1d67c-3a8d-1224-e9f0-5f7725a3dc10@redhat.com>
 <20190730110633-mutt-send-email-mst@kernel.org>
 <421a1af6-df06-e4a6-b34f-526ac123bc4a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421a1af6-df06-e4a6-b34f-526ac123bc4a@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 04:49:32PM +0800, Jason Wang wrote:
> Yes, looking at the synchronization implemented by other MMU notifiers.
> Vhost is even the simplest.

I think that is only because it calls gup under a spinlock, which is,
IMHO, not great.

Jason
