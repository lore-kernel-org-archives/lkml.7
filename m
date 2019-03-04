Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9301BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635092082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dR3rbdXm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfCDIGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:06:35 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33826 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfCDIGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:06:35 -0500
Received: by mail-pf1-f196.google.com with SMTP id u9so2437090pfn.1;
        Mon, 04 Mar 2019 00:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PK7rdtt5Ad1yU7g4P6dJDoQSxRfS0CWU2bWY21Y4Lcs=;
        b=dR3rbdXmXVsOtmJE/wKJ0v53Cq0idr54x5R2Rw6yyg+Z4v9qCHHyE69FdyQvQN4/Id
         jrJCC/G2A1LYyiSlVHRwXvZs9hZ+m0GcZIpyBcvSBIBK6oGm8A1J4xt+EqaZexBxyoYg
         Cjukz/Xkzt+a6YIyue8XM1lxQ1vOo40I47YxAiy0NSw+nNYaoQWSDJouvNN+99fV8q2h
         ZTvaUe5jDUMFSJQdQwovuk8wpILzas1l3a6OLvGjp3weCT5ubbsjPh4RxVyPZ1mrPWfx
         JfXMcRGxFJA2EvTOXzTwdYY7OK7Rn1AbJexsPm0RgWIg1r9VY9GN+yDySNKagGL9AWiX
         GzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PK7rdtt5Ad1yU7g4P6dJDoQSxRfS0CWU2bWY21Y4Lcs=;
        b=C15tk84EMQTRdHQdPV7Xm3oXC/xn1m0onsn/9coKWfRhqNScFBZDgwOFwYmpi7RdyX
         bBOe7sr8gmujBsc5TlF10bEnjrWoKiSfXvmwXtdfECrLHqYytJzR4sUz3IppsS0dASeR
         uUrKX0GSLxTpogRek6BaxKQ1vBit7HrO0oCqnKAgHdjmDUlD4YzIOM7N61iVNLA8FSZs
         +W1UwAPH7nB4bZuK5b5LHR94SpytxB8cO+W6EeCp61kKlP0noGbRTTCCYOJTqp0R6fV+
         LsDPilJwUdTnDacNtFz04QK3cLjUeasvQ/czOj0GqiLWIHoCup58vy0LQOghAAlm5PQG
         lX4A==
X-Gm-Message-State: APjAAAW+cjSXZ8CX9LdUTA6Aj/mA2hqq6CUHLyeKTPndb9nP6gLqNCM0
        I9IZI7i5nrioRDageCoYeF8=
X-Google-Smtp-Source: APXvYqx2mF9zBi5jzHCzwQVeHqIlTjW6rQmGxReIfuAzw8OUKy298YhdAtBsWL15ZYQCIyCB3htHUw==
X-Received: by 2002:a17:902:e512:: with SMTP id ck18mr18869097plb.46.1551686794503;
        Mon, 04 Mar 2019 00:06:34 -0800 (PST)
Received: from localhost ([175.223.38.45])
        by smtp.gmail.com with ESMTPSA id p5sm7291898pfn.154.2019.03.04.00.06.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 00:06:33 -0800 (PST)
Date:   Mon, 4 Mar 2019 17:06:30 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Calvin Owens <calvinowens@fb.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 4/4] printk: Add a device attribute for the per-console
 loglevel
Message-ID: <20190304080630.GA4495@jagdpanzerIV>
References: <cover.1551486732.git.calvinowens@fb.com>
 <4f71564063a07837e3c4df41326bad25e7dc4db4.1551486733.git.calvinowens@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f71564063a07837e3c4df41326bad25e7dc4db4.1551486733.git.calvinowens@fb.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/01/19 16:48), Calvin Owens wrote:
> +static ssize_t loglevel_store(struct device *dev, struct device_attribute *attr,
> +			      const char *buf, size_t count)
> +{
> +	struct console *con = container_of(dev, struct console, dev);
> +	ssize_t ret;
> +	int tmp;
> +
> +	ret = kstrtoint(buf, 10, &tmp);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (tmp < LOGLEVEL_EMERG)
> +		return -ERANGE;
> +
> +	/*
> +	 * Mimic the behavior of /dev/kmsg with respect to minimum_loglevel.
> +	 */
> +	if (tmp < minimum_console_loglevel)
> +		tmp = minimum_console_loglevel;
> +
> +	con->level = tmp;
> +	return ret;
> +}
> +
> +static DEVICE_ATTR_RW(loglevel);
> +
> +static struct attribute *console_sysfs_attrs[] = {
> +	&dev_attr_loglevel.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(console_sysfs);
> +
>  static struct bus_type console_subsys = {
>  	.name = "console",
> +	.dev_groups = console_sysfs_groups,
>  };

Do we really need to change this dynamically? Console options are
traditionally static (boot param or DT). Can we also be happy with
the static per-console loglevel?

	-ss
