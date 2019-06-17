Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744A5C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 20:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD6E20644
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 20:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbfFQUoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 16:44:25 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45632 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfFQUoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 16:44:25 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hcyUI-0004t6-0V; Mon, 17 Jun 2019 22:44:22 +0200
Date:   Mon, 17 Jun 2019 22:44:21 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
cc:     linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/7] rslib: Add tests for the encoder and decoder
In-Reply-To: <20190330182947.8823-2-ferdinand.blomqvist@gmail.com>
Message-ID: <alpine.DEB.2.21.1906172229190.1963@nanos.tec.linutronix.de>
References: <20190330182947.8823-1-ferdinand.blomqvist@gmail.com> <20190330182947.8823-2-ferdinand.blomqvist@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ferdinand,

On Sat, 30 Mar 2019, Ferdinand Blomqvist wrote:

Sorry for the horrible long delay. I'm just drowned in backlog.

....

> There are a couple of options for the tests:
> 
> - Verbosity.
> 
> - Whether to test for correct behaviour beyond capacity. Default is to
>   test beyond capacity.
> 
> - Whether to allow erasures without symbol corruption. Defaults to yes.
> 
> Note that the tests take a couple of minutes to complete.

Very well written changelog!


> +/* List of codes to test */
> +static struct etab Tab[] = {
> +	{2,	0x7,	1,	1,	1,	100000	},
> +	{3,	0xb,	1,	1,	2,	100000	},
> +	{3,	0xb,	1,	1,	3,	100000	},
> +	{3,	0xb,	2,	1,	4,	100000	},
> +	{4,	0x13,	1,	1,	4,	10000	},
> +	{5,	0x25,	1,	1,	6,	1000	},
> +	{6,	0x43,	3,	1,	8,	100	},
> +	{7,	0x89,	1,	1,	10,	100	},
> +	{8,	0x11d,	1,	1,	32,	100	},
> +	{8,	0x187,	112,	11,	32,	100	},
> +	/*
> +	 * {9,	0x211,	1,	1,	32,	100	},
> +	 * {10,	0x409,	1,	1,	32,	100	},
> +	 * {11,	0x805,	1,	1,	32,	100	},
> +	 * {12,	0x1053	1,	1,	32,	50	},
> +	 * {12,	0x1053	1,	1,	64,	50	},
> +	 * {13,	0x201b	1,	1,	32,	20	},
> +	 * {13,	0x201b	1,	1,	64,	20	},
> +	 * {14,	0x4443	1,	1,	32,	10	},
> +	 * {14,	0x4443	1,	1,	64,	10	},
> +	 * {15,	0x8003	1,	1,	32,	5	},
> +	 * {15,	0x8003	1,	1,	64,	5	},
> +	 * {16,	0x1100	1,	1,	32,	5	},
> +	 */

I assume these are enabled later. We don't do that commented out stuff in
general. If it's used later, then add it with a separate patch. If not just
leave it alone.

> +	{0, 0, 0, 0, 0, 0},
> +};
> +
> +
> +struct estat {
> +	int dwrong;
> +	int irv;
> +	int wepos;
> +	int nwords;
> +};
> +
> +struct bcstat {
> +	int rfail;
> +	int rsuccess;
> +	int noncw;
> +	int nwords;
> +};
> +
> +struct wspace {
> +	uint16_t *c;		/* sent codeword */
> +	uint16_t *r;		/* received word */
> +	uint16_t *s;		/* syndrome */
> +	uint16_t *corr;		/* correction buffer */
> +	int *errlocs;
> +	int *derrlocs;

Pet pieve comment. I generally prefer tabular layout of structs as it's
simpler to follow

struct wspace {
	uint16_t	*c;		/* sent codeword */
	uint16_t	*r;		/* received word */
	uint16_t	*s;		/* syndrome */
	uint16_t	*corr;		/* correction buffer */
	int		*errlocs;
	int		*derrlocs;

Hmm?

> +
> +static double Pad[] = {0, 0.25, 0.5, 0.75, 1.0};

This is kernel code. You cannot use the FPU without special care. But for
that use case doing so would be actually overkill.

> +	for (i = 0; i < ARRAY_SIZE(Pad); i++) {
> +		int pad = Pad[i] * max_pad;

That can be simply expressed:

struct pad {
	int	mult;
	int	shift;
};

static struct pad pad[] = {
	{ 0, 0 },
	{ 1, 2 },
	{ 1, 1 },
	{ 3, 2 },
	{ 1, 0 },
};

	for (i = 0; i < ARRAY_SIZE(pad); i++) {
		int pad = (pad[i].mult * max_pad) >> pad[i].shift;

Also note, that I got rid of the CamelCase name.

> +static struct wspace *alloc_ws(struct rs_codec *rs)
> +{
> +	int nn = rs->nn;
> +	int nroots = rs->nroots;
> +	struct wspace *ws;

Yet another pet pieve comment for readability. Order variables in reverse
fir tree order.

	int nroots = rs->nroots;
	struct wspace *ws;
	int nn = rs->nn;

> +	ws = kzalloc(sizeof(*ws), GFP_KERNEL);
> +	if (!ws)
> +		return NULL;
> +
> +	ws->c = kmalloc_array(2 * (nn + nroots),
> +				sizeof(uint16_t), GFP_KERNEL);
> +	if (!ws->c)
> +		goto err;
> +
> +	ws->r = ws->c + nn;
> +	ws->s = ws->r + nn;
> +	ws->corr = ws->s + nroots;
> +
> +	ws->errlocs = kmalloc_array(nn + nroots, sizeof(int), GFP_KERNEL);
> +	if (!ws->c)
> +		goto err;
> +
> +	ws->derrlocs = ws->errlocs + nn;
> +	return ws;
> +
> +err:
> +	kfree(ws->errlocs);
> +	kfree(ws->c);
> +	kfree(ws);

If you move free_ws() above this function you can replace this kfree()
sequence with

	free_ws();

> +	return NULL;

Just nitpicks, except for the FPU issue. Other than that this looks great.

Thanks,

	tglx
