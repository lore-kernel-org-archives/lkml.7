Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E50C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7113E214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Y6OQ3mwS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfJJPT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 11:19:57 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:18366 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725909AbfJJPT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 11:19:57 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9AFBl84003663;
        Thu, 10 Oct 2019 17:19:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=AOLOsiRuQLPzZHvIlxS4fgBJyoq+OjJ5HzMhnkKKIIg=;
 b=Y6OQ3mwStMshpzMM4h8APftE4hodoAdXjie/5tglR0c5ZFLFzwK71bSzkG4vhI7ZNGOh
 gk/k+jsKhTB/SJhv1cQmBJQQ6K2YTECTy5Y12BrEhVXwlbAyKjqjxubmcI6S/56wAeNO
 YK/kJLAHSF1seT4sq9BrldTtK/1KdHJ6mxOfy0lOwcfa/mVGWesttuP1w9cOr2/Eezkr
 9JqRyOnLhJdRn1kuk7smzhJer4S6EbpeQYUj6JbEVfqHnFXXlVRSrQOZ8VcpVBdWb5ar
 JWmrZk27fI3ZsnMPolhJ2fECLfLDP/Fp4C0TQfPASJnSrWrE+TsjylprByjk3NeyAK34 5w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2vegahd73y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Oct 2019 17:19:48 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0F2EB10002A;
        Thu, 10 Oct 2019 17:19:43 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6D64D2B434E;
        Thu, 10 Oct 2019 17:19:43 +0200 (CEST)
Received: from SFHDAG5NODE3.st.com (10.75.127.15) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 10 Oct
 2019 17:19:43 +0200
Received: from SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47]) by
 SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47%20]) with mapi id
 15.00.1473.003; Thu, 10 Oct 2019 17:19:43 +0200
From:   Fabien DESSENNE <fabien.dessenne@st.com>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Suman Anna <s-anna@ti.com>, Jonathan Corbet <corbet@lwn.net>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: RE: [PATCH v3] hwspinlock: allow sharing of hwspinlocks
Thread-Topic: [PATCH v3] hwspinlock: allow sharing of hwspinlocks
Thread-Index: AQHVaKjapbMgkxsKZUeyg+vcLkCPcqdUKkIg
Date:   Thu, 10 Oct 2019 15:19:43 +0000
Message-ID: <cacef63490014605b5eb8015c4002df2@SFHDAG5NODE3.st.com>
References: <1568210227-32135-1-git-send-email-fabien.dessenne@st.com>
In-Reply-To: <1568210227-32135-1-git-send-email-fabien.dessenne@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-10_05:2019-10-10,2019-10-10 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn, Suman, and others

Do you have any comments regarding this patch?

BR
Fabien


> -----Original Message-----
> From: Fabien DESSENNE <fabien.dessenne@st.com>
> Sent: mercredi 11 septembre 2019 15:57
> To: Ohad Ben-Cohen <ohad@wizery.com>; Bjorn Andersson
> <bjorn.andersson@linaro.org>; Suman Anna <s-anna@ti.com>; Jonathan Corbet
> <corbet@lwn.net>; linux-remoteproc@vger.kernel.org; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Fabien DESSENNE <fabien.dessenne@st.com>; linux-stm32@st-md-
> mailman.stormreply.com
> Subject: [PATCH v3] hwspinlock: allow sharing of hwspinlocks
>=20
> Allow several clients to request (hwspin_lock_request_specific()) the sam=
e lock.
> In addition to that, protect a given lock from being locked
> (hwspin_trylock{_...}()) by more that one client at a time.
>=20
> Since the RAW and IN_ATOMIC modes do not implement that protection (unlik=
e
> the default, IRQ and IRQSTATE modes that make use of spin_lock{_irq,
> _irqsave}), protect __hwspin_trylock with the atomic bitop test_and_set_b=
it().
> This bitop is atomic (SMP-safe), does not disable neither preemption nor
> interrupts, hence it preserves the RAW and IN_ATOMIC modes constraints.
>=20
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> ---
> Changes since v2:
> - Drop the DeviceTree-based implementation.
> - Do not let the choice between exclusive and shared usage : locks are
>   always shared.
> - Add a protection (atomic bitop) working in any modes to allow safe
>   sharing between clients.
>=20
> Changes since v1:
> - Removed useless 'status =3D "okay"' from stm32mp157c.dtsi
> ---
>  Documentation/hwspinlock.txt             |  9 ++-
>  drivers/hwspinlock/hwspinlock_core.c     | 98 +++++++++++++++++++++++---=
---
> ---
>  drivers/hwspinlock/hwspinlock_internal.h |  4 ++
>  3 files changed, 81 insertions(+), 30 deletions(-)
>=20
> diff --git a/Documentation/hwspinlock.txt b/Documentation/hwspinlock.txt =
index
> 6f03713..5f6f660 100644
> --- a/Documentation/hwspinlock.txt
> +++ b/Documentation/hwspinlock.txt
> @@ -53,9 +53,8 @@ Should be called from a process context (might sleep).
>=20
>    struct hwspinlock *hwspin_lock_request_specific(unsigned int id);
>=20
> -Assign a specific hwspinlock id and return its address, or NULL -if that
> hwspinlock is already in use. Usually board code will -be calling this fu=
nction in
> order to reserve specific hwspinlock
> +Assign a specific hwspinlock id and return its address. Usually board
> +code will be calling this function in order to reserve specific
> +hwspinlock
>  ids for predefined purposes.
>=20
>  Should be called from a process context (might sleep).
> @@ -449,11 +448,15 @@ of which represents a single hardware lock::
>  	* struct hwspinlock - this struct represents a single hwspinlock instan=
ce
>  	* @bank: the hwspinlock_device structure which owns this lock
>  	* @lock: initialized and used by hwspinlock core
> +	* @is_locked: whether this lock is currently locked
> +	* @reqcount: number of users having requested this lock
>  	* @priv: private data, owned by the underlying platform-specific
> hwspinlock drv
>  	*/
>  	struct hwspinlock {
>  		struct hwspinlock_device *bank;
>  		spinlock_t lock;
> +		unsigned long is_locked;
> +		unsigned int reqcount;
>  		void *priv;
>  	};
>=20
> diff --git a/drivers/hwspinlock/hwspinlock_core.c
> b/drivers/hwspinlock/hwspinlock_core.c
> index 8862445..e9d3de10 100644
> --- a/drivers/hwspinlock/hwspinlock_core.c
> +++ b/drivers/hwspinlock/hwspinlock_core.c
> @@ -29,6 +29,7 @@
>=20
>  /* radix tree tags */
>  #define HWSPINLOCK_UNUSED	(0) /* tags an hwspinlock as unused */
> +#define HWSPINLOCK_DYN_ASSIGN	(1) /* dynamically assigned
> hwspinlock */
>=20
>  /*
>   * A radix tree is used to maintain the available hwspinlock instances.
> @@ -96,14 +97,25 @@ int __hwspin_trylock(struct hwspinlock *hwlock, int
> mode, unsigned long *flags)
>  	BUG_ON(!flags && mode =3D=3D HWLOCK_IRQSTATE);
>=20
>  	/*
> +	 * Check if the lock is already taken by another context on the local
> +	 * cpu.
> +	 * Calling atomic test_and_set_bit_lock() ensures that hwspinlock is
> +	 * SMP-safe (so we can take it from additional contexts on the local
> +	 * host) in any mode, even those where we do not make use of the local
> +	 * spinlock.
> +	 */
> +
> +	if (test_and_set_bit_lock(0, &hwlock->is_locked))
> +		return -EBUSY;
> +
> +	/*
>  	 * This spin_lock{_irq, _irqsave} serves three purposes:
>  	 *
>  	 * 1. Disable preemption, in order to minimize the period of time
>  	 *    in which the hwspinlock is taken. This is important in order
>  	 *    to minimize the possible polling on the hardware interconnect
>  	 *    by a remote user of this lock.
> -	 * 2. Make the hwspinlock SMP-safe (so we can take it from
> -	 *    additional contexts on the local host).
> +	 * 2. Make the hwspinlock SMP-safe.
>  	 * 3. Ensure that in_atomic/might_sleep checks catch potential
>  	 *    problems with hwspinlock usage (e.g. scheduler checks like
>  	 *    'scheduling while atomic' etc.)
> @@ -124,9 +136,9 @@ int __hwspin_trylock(struct hwspinlock *hwlock, int
> mode, unsigned long *flags)
>  		break;
>  	}
>=20
> -	/* is lock already taken by another context on the local cpu ? */
> +	/* sanity check (this shouldn't happen) */
>  	if (!ret)
> -		return -EBUSY;
> +		goto clear;
>=20
>  	/* try to take the hwspinlock device */
>  	ret =3D hwlock->bank->ops->trylock(hwlock);
> @@ -149,7 +161,7 @@ int __hwspin_trylock(struct hwspinlock *hwlock, int
> mode, unsigned long *flags)
>  			break;
>  		}
>=20
> -		return -EBUSY;
> +		goto clear;
>  	}
>=20
>  	/*
> @@ -165,6 +177,11 @@ int __hwspin_trylock(struct hwspinlock *hwlock, int
> mode, unsigned long *flags)
>  	mb();
>=20
>  	return 0;
> +
> +clear:
> +	/* Clear is_locked */
> +	clear_bit_unlock(0, &hwlock->is_locked);
> +	return -EBUSY;
>  }
>  EXPORT_SYMBOL_GPL(__hwspin_trylock);
>=20
> @@ -299,6 +316,9 @@ void __hwspin_unlock(struct hwspinlock *hwlock, int
> mode, unsigned long *flags)
>  		spin_unlock(&hwlock->lock);
>  		break;
>  	}
> +
> +	/* Clear is_locked set while locking */
> +	clear_bit_unlock(0, &hwlock->is_locked);
>  }
>  EXPORT_SYMBOL_GPL(__hwspin_unlock);
>=20
> @@ -504,7 +524,9 @@ int hwspin_lock_register(struct hwspinlock_device *ba=
nk,
> struct device *dev,
>  		hwlock =3D &bank->lock[i];
>=20
>  		spin_lock_init(&hwlock->lock);
> +		clear_bit(0, &hwlock->is_locked);
>  		hwlock->bank =3D bank;
> +		hwlock->reqcount =3D 0;
>=20
>  		ret =3D hwspin_lock_register_single(hwlock, base_id + i);
>  		if (ret)
> @@ -664,12 +686,16 @@ static int __hwspin_lock_request(struct hwspinlock
> *hwlock)
>  		return ret;
>  	}
>=20
> -	/* mark hwspinlock as used, should not fail */
> -	tmp =3D radix_tree_tag_clear(&hwspinlock_tree, hwlock_to_id(hwlock),
> -							HWSPINLOCK_UNUSED);
> +	/* update reqcount */
> +	if (!hwlock->reqcount++) {
> +		/* first request, mark hwspinlock as used, should not fail */
> +		tmp =3D radix_tree_tag_clear(&hwspinlock_tree,
> +					   hwlock_to_id(hwlock),
> +					   HWSPINLOCK_UNUSED);
>=20
> -	/* self-sanity check that should never fail */
> -	WARN_ON(tmp !=3D hwlock);
> +		/* self-sanity check that should never fail */
> +		WARN_ON(tmp !=3D hwlock);
> +	}
>=20
>  	return ret;
>  }
> @@ -706,7 +732,7 @@ EXPORT_SYMBOL_GPL(hwspin_lock_get_id);
>   */
>  struct hwspinlock *hwspin_lock_request(void)  {
> -	struct hwspinlock *hwlock;
> +	struct hwspinlock *hwlock, *tmp;
>  	int ret;
>=20
>  	mutex_lock(&hwspinlock_tree_lock);
> @@ -728,6 +754,13 @@ struct hwspinlock *hwspin_lock_request(void)
>  	if (ret < 0)
>  		hwlock =3D NULL;
>=20
> +	/* mark this hwspinlock as dynamically assigned */
> +	tmp =3D radix_tree_tag_set(&hwspinlock_tree, hwlock_to_id(hwlock),
> +				 HWSPINLOCK_DYN_ASSIGN);
> +
> +	/* self-sanity check which should never fail */
> +	WARN_ON(tmp !=3D hwlock);
> +
>  out:
>  	mutex_unlock(&hwspinlock_tree_lock);
>  	return hwlock;
> @@ -764,18 +797,19 @@ struct hwspinlock
> *hwspin_lock_request_specific(unsigned int id)
>  	/* sanity check (this shouldn't happen) */
>  	WARN_ON(hwlock_to_id(hwlock) !=3D id);
>=20
> -	/* make sure this hwspinlock is unused */
> -	ret =3D radix_tree_tag_get(&hwspinlock_tree, id, HWSPINLOCK_UNUSED);
> -	if (ret =3D=3D 0) {
> -		pr_warn("hwspinlock %u is already in use\n", id);
> +	/* mark as used and power up */
> +	ret =3D __hwspin_lock_request(hwlock);
> +	if (ret < 0) {
>  		hwlock =3D NULL;
>  		goto out;
>  	}
>=20
> -	/* mark as used and power up */
> -	ret =3D __hwspin_lock_request(hwlock);
> -	if (ret < 0)
> -		hwlock =3D NULL;
> +	/*
> +	 * warn if this lock is also used by another client which got this lock
> +	 * with dynamic assignment using the hwspin_lock_request() API
> +	 */
> +	if (radix_tree_tag_get(&hwspinlock_tree, id,
> HWSPINLOCK_DYN_ASSIGN))
> +		pr_warn("hwspinlock %u is shared with a 'dynamic' user\n", id);
>=20
>  out:
>  	mutex_unlock(&hwspinlock_tree_lock);
> @@ -799,7 +833,7 @@ int hwspin_lock_free(struct hwspinlock *hwlock)  {
>  	struct device *dev;
>  	struct hwspinlock *tmp;
> -	int ret;
> +	int ret, id;
>=20
>  	if (!hwlock) {
>  		pr_err("invalid hwlock\n");
> @@ -810,30 +844,40 @@ int hwspin_lock_free(struct hwspinlock *hwlock)
>  	mutex_lock(&hwspinlock_tree_lock);
>=20
>  	/* make sure the hwspinlock is used */
> -	ret =3D radix_tree_tag_get(&hwspinlock_tree, hwlock_to_id(hwlock),
> -							HWSPINLOCK_UNUSED);
> +	id =3D hwlock_to_id(hwlock);
> +	ret =3D radix_tree_tag_get(&hwspinlock_tree, id, HWSPINLOCK_UNUSED);
>  	if (ret =3D=3D 1) {
>  		dev_err(dev, "%s: hwlock is already free\n", __func__);
>  		dump_stack();
>  		ret =3D -EINVAL;
> -		goto out;
> +		goto out_unlock;
>  	}
>=20
>  	/* notify the underlying device that power is not needed */
>  	ret =3D pm_runtime_put(dev);
>  	if (ret < 0)
> -		goto out;
> +		goto out_unlock;
> +
> +	/* update reqcount */
> +	if (--hwlock->reqcount)
> +		goto out_put;
>=20
>  	/* mark this hwspinlock as available */
> -	tmp =3D radix_tree_tag_set(&hwspinlock_tree, hwlock_to_id(hwlock),
> -							HWSPINLOCK_UNUSED);
> +	tmp =3D radix_tree_tag_set(&hwspinlock_tree, id,
> HWSPINLOCK_UNUSED);
>=20
>  	/* sanity check (this shouldn't happen) */
>  	WARN_ON(tmp !=3D hwlock);
>=20
> +	/* clear the dynamically assigned tag */
> +	tmp =3D radix_tree_tag_clear(&hwspinlock_tree, id,
> +HWSPINLOCK_DYN_ASSIGN);
> +
> +	/* self-sanity check which should never fail */
> +	WARN_ON(tmp !=3D hwlock);
> +
> +out_put:
>  	module_put(dev->driver->owner);
>=20
> -out:
> +out_unlock:
>  	mutex_unlock(&hwspinlock_tree_lock);
>  	return ret;
>  }
> diff --git a/drivers/hwspinlock/hwspinlock_internal.h
> b/drivers/hwspinlock/hwspinlock_internal.h
> index 9eb6bd0..a3aae55 100644
> --- a/drivers/hwspinlock/hwspinlock_internal.h
> +++ b/drivers/hwspinlock/hwspinlock_internal.h
> @@ -35,11 +35,15 @@ struct hwspinlock_ops {
>   * struct hwspinlock - this struct represents a single hwspinlock instan=
ce
>   * @bank: the hwspinlock_device structure which owns this lock
>   * @lock: initialized and used by hwspinlock core
> + * @is_locked: whether this lock is currently locked
> + * @reqcount: number of users having requested this lock
>   * @priv: private data, owned by the underlying platform-specific hwspin=
lock drv
>   */
>  struct hwspinlock {
>  	struct hwspinlock_device *bank;
>  	spinlock_t lock;
> +	unsigned long is_locked;
> +	unsigned int reqcount;
>  	void *priv;
>  };
>=20
> --
> 2.7.4

