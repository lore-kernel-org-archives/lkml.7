Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E0FC32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA8E32087F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PorJPIog"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbgAIJeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:34:46 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33589 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729623AbgAIJeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:34:46 -0500
Received: by mail-pl1-f194.google.com with SMTP id ay11so2325445plb.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 01:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L9XB5AN+fravHpIS0JAibGbZsaJ2BHkQqcH0VnEvYUE=;
        b=PorJPIogHEcRiQQYYPYQA93p0KSOs7yXFv+DdBN6acem8TD7Q8Gdw/GBdgjYOLD2n+
         7PVACTQFrcSvfZzuHf00SmwP9JzAHHXkWuqN8iZFHMERgQWA+66Ps8WgZotTIb+J3Ipi
         0erZX5Z6d+JOwrdoC0tGEjNJ5DTnri5NPSEtKZEBu5KczVTo9PkhQn718ncCtZMKizlq
         uGqRveykBhnuLY/k/qj17tJNcCy/1wwPUR8VebD6NpWzeedf71pvVoDAw4ELbcD4tLbR
         syKYkI1jnRsv28E+lqRM/dUpTMB9+3nVY3yptr8p4W0KjreyhDatY9+WIfWXrcmOUj97
         mJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L9XB5AN+fravHpIS0JAibGbZsaJ2BHkQqcH0VnEvYUE=;
        b=Bv3kgd8dI8l9W7Ts/iB5J61pksproAag67mRTw0fQFFhs2D8x8UGEpcrn3Fg3HZa+V
         yv58zsGLT5/AEw/rTHt4wj1ae+ekzZ+ql7jlvyH1LfOk0kdZeUx4Lbt0BzFFXz02fbVU
         OSy79Ai49jWLloryzW1sdeRu6fAYb4GSO6QjysOemC5YEoYxWni3uKGJ5LcQebZbdlpm
         keBIDvoGj7ERdZ5ZgoEHK3znkigCAOla4w78Z+oH/SLI7JPOUyqqIDUiKiD/4zWJOCc8
         DLlvwWwgnv0r9Pe55p//NWk+QLrw7XKT8FCOGQl/KWxRlMikOe/PY8xVH84AqOb5DMzu
         qKZg==
X-Gm-Message-State: APjAAAUEBJgE0zPNzy6DkmjFPX0FIbaAZtOGHgnhu0LPGy3vJHec6AZo
        ivxXEKW31pjZjvur8VZkHANQ5Q==
X-Google-Smtp-Source: APXvYqzBfewSQPZvAwkpT36xnTY57nZ7Sz3UFzijvnhCeEbYI1srm+RA/XMXe2Dpmu86TBCiFsqYnQ==
X-Received: by 2002:a17:90a:778a:: with SMTP id v10mr4042349pjk.26.1578562485403;
        Thu, 09 Jan 2020 01:34:45 -0800 (PST)
Received: from localhost ([122.172.140.51])
        by smtp.gmail.com with ESMTPSA id e16sm6522308pgk.77.2020.01.09.01.34.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jan 2020 01:34:44 -0800 (PST)
Date:   Thu, 9 Jan 2020 15:04:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, peng.fan@nxp.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] firmware: arm_scmi: Make scmi core independent of
 transport type
Message-ID: <20200109093442.4jt44eu2zlmjaq3f@vireshk-i7>
References: <5c545c2866ba075ddb44907940a1dae1d823b8a1.1575019719.git.viresh.kumar@linaro.org>
 <CAK8P3a3=q2zX9xQo7eZKp7e70rAeNB8VoSjg2aE06QJuSw8y3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3=q2zX9xQo7eZKp7e70rAeNB8VoSjg2aE06QJuSw8y3Q@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-01-20, 09:18, Arnd Bergmann wrote:
> On Fri, Nov 29, 2019 at 10:32 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > The SCMI specification is fairly independent of the transport protocol,
> > which can be a simple mailbox (already implemented) or anything else.
> > The current Linux implementation however is very much dependent of the
> > mailbox transport layer.
> >
> > This patch makes the SCMI core code (driver.c) independent of the
> > mailbox transport layer and moves all mailbox related code to a new
> > file: mailbox.c.
> >
> > We can now implement more transport protocols to transport SCMI
> > messages.
> >
> > The transport protocols just need to provide struct scmi_transport_ops,
> > with its version of the callbacks to enable exchange of SCMI messages.
> >
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Conceptually I think this is fine, but as others have said, it would be
> better to have another transport implementation posted along with this
> to see if the interfaces actually work out.

@Sudeep/Vincent: Do you think we can add another transport
implementation something right away for it ?

@Peng ?

> > +/**
> > + * struct scmi_chan_info - Structure representing a SCMI channel information
> > + *
> > + * @payload: Transmit/Receive payload area
> > + * @dev: Reference to device in the SCMI hierarchy corresponding to this
> > + *      channel
> > + * @handle: Pointer to SCMI entity handle
> > + * @transport_info: Transport layer related information
> > + */
> > +struct scmi_chan_info {
> > +       void __iomem *payload;
> > +       struct device *dev;
> > +       struct scmi_handle *handle;
> > +       void *transport_info;
> > +};
> 
> I would assume that with another transport, the 'payload' pointer would
> not be __iomem

Hmm, okay. I just separated things based on the current transport and
didn't add much changes on top of it as I wasn't sure how things are
going to look with next transport and so left the changes for then.

I can now drop it though.

> > +static int scmi_set_transport_ops(struct scmi_info *info)
> > +{
> > +       struct scmi_transport_ops *ops;
> > +       struct device *dev = info->dev;
> > +
> > +       /* Only mailbox method supported for now */
> > +       ops = scmi_mailbox_get_ops(dev);
> > +       if (!ops) {
> > +               dev_err(dev, "Transport protocol not found in %pOF\n",
> > +                       dev->of_node);
> > +               return -EINVAL;
> > +       }
> > +
> > +       info->transport_ops = ops;
> > +       return 0;
> > +}
> 
> This looks odd: rather than guessing the transport type based on
> random DT properties, I would prefer to have it determined by
> the device compatible string, and have different drivers bind
> to one of them each, with each driver linking against a common
> base implementation, either as separate modules or in one file.

Since there are no platforms using the scmi binding in mainline kernel
for now, it won't be difficult to add new compatible strings. So
should this be done like:

        compatible = "arm,scmi", "arm,scmi-mailbox";

or just
        compatible = "arm,scmi-mailbox";

?
-- 
viresh
