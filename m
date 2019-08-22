Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E679AC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 16:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE7B123400
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 16:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390084AbfHVQg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 12:36:59 -0400
Received: from mga07.intel.com ([134.134.136.100]:39195 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728591AbfHVQg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 12:36:59 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 09:36:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,417,1559545200"; 
   d="p7s'?scan'208";a="354341857"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by orsmga005.jf.intel.com with ESMTP; 22 Aug 2019 09:36:57 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.119]) by
 ORSMSX106.amr.corp.intel.com ([169.254.1.16]) with mapi id 14.03.0439.000;
 Thu, 22 Aug 2019 09:36:56 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC:     "hch@lst.de" <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH V6 2/2] genirq/affinity: Spread vectors on node
 according to nr_cpu ratio
Thread-Topic: [PATCH V6 2/2] genirq/affinity: Spread vectors on node
 according to nr_cpu ratio
Thread-Index: AQHVVoya+IWYIZjLtEOCThGRasQmmKcH192A
Date:   Thu, 22 Aug 2019 16:36:56 +0000
Message-ID: <2ae75c20f16aff1e975f8e5034ca62a4a2c8e554.camel@intel.com>
References: <20190819124937.9948-1-ming.lei@redhat.com>
         <20190819124937.9948-3-ming.lei@redhat.com>
In-Reply-To: <20190819124937.9948-3-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.115.165]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-GJXJ3F8mpTcIzs/xWm2w"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-GJXJ3F8mpTcIzs/xWm2w
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

lgtm. Don't know how often we'll see these configurations but it looks
like it'll be handled gracefully
Thanks for the effort

Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>

On Mon, 2019-08-19 at 20:49 +0800, Ming Lei wrote:
> Now __irq_build_affinity_masks() spreads vectors evenly per node, and
> all vectors may not be spread in case that each numa node has different
> CPU number, then the warning in irq_build_affinity_masks() can
> be triggered.
>=20
> Improve current spreading algorithm by assigning vectors according to
> the ratio of node's nr_cpu to nr_remaining_cpus, meantime running the
> assignment from smaller nodes to bigger nodes to guarantee that every
> active node gets allocated at least one vector, then we can avoid
> cross-node spread in normal situation.
>=20
> Meantime the reported warning can be fixed.
>=20
> Another big goodness is that the spread approach becomes more fair if
> node has different CPU number.
>=20
> For example, on the following machine:
> 	[root@ktest-01 ~]# lscpu
> 	...
> 	CPU(s):              16
> 	On-line CPU(s) list: 0-15
> 	Thread(s) per core:  1
> 	Core(s) per socket:  8
> 	Socket(s):           2
> 	NUMA node(s):        2
> 	...
> 	NUMA node0 CPU(s):   0,1,3,5-9,11,13-15
> 	NUMA node1 CPU(s):   2,4,10,12
>=20
> When driver requests to allocate 8 vectors, the following spread can
> be got:
> 	irq 31, cpu list 2,4
> 	irq 32, cpu list 10,12
> 	irq 33, cpu list 0-1
> 	irq 34, cpu list 3,5
> 	irq 35, cpu list 6-7
> 	irq 36, cpu list 8-9
> 	irq 37, cpu list 11,13
> 	irq 38, cpu list 14-15
>=20
> Without this patch, kernel warning is triggered on above situation, and
> allocation result was supposed to be 4 vectors for each node.
>=20
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: linux-nvme@lists.infradead.org,
> Cc: Jon Derrick <jonathan.derrick@intel.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Reported-by: Jon Derrick <jonathan.derrick@intel.com>
> Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  kernel/irq/affinity.c | 239 +++++++++++++++++++++++++++++++++++-------
>  1 file changed, 200 insertions(+), 39 deletions(-)
>=20
> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> index c7cca942bd8a..d905e844bf3a 100644
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -7,6 +7,7 @@
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include <linux/cpu.h>
> +#include <linux/sort.h>
> =20
>  static void irq_spread_init_one(struct cpumask *irqmsk, struct cpumask *=
nmsk,
>  				unsigned int cpus_per_vec)
> @@ -94,6 +95,155 @@ static int get_nodes_in_cpumask(cpumask_var_t *node_t=
o_cpumask,
>  	return nodes;
>  }
> =20
> +struct node_vectors {
> +	unsigned id;
> +
> +	union {
> +		unsigned nvectors;
> +		unsigned ncpus;
> +	};
> +};
> +
> +static int ncpus_cmp_func(const void *l, const void *r)
> +{
> +	const struct node_vectors *ln =3D l;
> +	const struct node_vectors *rn =3D r;
> +
> +	return ln->ncpus - rn->ncpus;
> +}
> +
> +/*
> + * Allocate vector number for each node, so that for each node:
> + *
> + * 1) the allocated number is >=3D 1
> + *
> + * 2) the allocated numbver is <=3D active CPU number of this node
> + *
> + * The actual allocated total vectors may be less than @numvecs when
> + * active total CPU number is less than @numvecs.
> + *
> + * Active CPUs means the CPUs in '@cpu_mask AND @node_to_cpumask[]'
> + * for each node.
> + */
> +static void alloc_nodes_vectors(unsigned int numvecs,
> +				const cpumask_var_t *node_to_cpumask,
> +				const struct cpumask *cpu_mask,
> +				const nodemask_t nodemsk,
> +				struct cpumask *nmsk,
> +				struct node_vectors *node_vectors)
> +{
> +	unsigned n, remaining_ncpus =3D 0;
> +
> +	for (n =3D 0; n < nr_node_ids; n++) {
> +		node_vectors[n].id =3D n;
> +		node_vectors[n].ncpus =3D UINT_MAX;
> +	}
> +
> +	for_each_node_mask(n, nodemsk) {
> +		unsigned ncpus;
> +
> +		cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
> +		ncpus =3D cpumask_weight(nmsk);
> +
> +		if (!ncpus)
> +			continue;
> +		remaining_ncpus +=3D ncpus;
> +		node_vectors[n].ncpus =3D ncpus;
> +	}
> +
> +	numvecs =3D min_t(unsigned, remaining_ncpus, numvecs);
> +
> +	sort(node_vectors, nr_node_ids, sizeof(node_vectors[0]),
> +	     ncpus_cmp_func, NULL);
> +
> +	/*
> +	 * Allocate vectors for each node according to the ratio of this
> +	 * node's nr_cpus to remaining un-assigned ncpus. 'numvecs' is
> +	 * bigger than number of active numa nodes. Always start the
> +	 * allocation from the node with minimized nr_cpus.
> +	 *
> +	 * This way guarantees that each active node gets allocated at
> +	 * least one vector, and the theory is simple: over-allocation
> +	 * is only done when this node is assigned by one vector, so
> +	 * other nodes will be allocated >=3D 1 vector, since 'numvecs' is
> +	 * bigger than number of numa nodes.
> +	 *
> +	 * One perfect invariant is that number of allocated vectors for
> +	 * each node is <=3D CPU count of this node:
> +	 *
> +	 * 1) suppose there are two nodes: A and B
> +	 * 	ncpu(X) is CPU count of node X
> +	 * 	vecs(X) is the vector count allocated to node X via this
> +	 * 	algorithm
> +	 *
> +	 * 	ncpu(A) <=3D ncpu(B)
> +	 * 	ncpu(A) + ncpu(B) =3D N
> +	 * 	vecs(A) + vecs(B) =3D V
> +	 *
> +	 * 	vecs(A) =3D max(1, round_down(V * ncpu(A) / N))
> +	 * 	vecs(B) =3D V - vecs(A)
> +	 *
> +	 * 	both N and V are integer, and 2 <=3D V <=3D N, suppose
> +	 * 	V =3D N - delta, and 0 <=3D delta <=3D N - 2
> +	 *
> +	 * 2) obviously vecs(A) <=3D ncpu(A) because:
> +	 *
> +	 * 	if vecs(A) is 1, then vecs(A) <=3D ncpu(A) given
> +	 * 	ncpu(A) >=3D 1
> +	 *
> +	 * 	otherwise,
> +	 * 		vecs(A) <=3D V * ncpu(A) / N <=3D ncpu(A), given V <=3D N
> +	 *
> +	 * 3) prove how vecs(B) <=3D ncpu(B):
> +	 *
> +	 * 	if round_down(V * ncpu(A) / N) =3D=3D 0, vecs(B) won't be
> +	 * 	over-allocated, so vecs(B) <=3D ncpu(B),
> +	 *
> +	 * 	otherwise:
> +	 *
> +	 * 	vecs(A) =3D
> +	 * 		round_down(V * ncpu(A) / N) =3D
> +	 * 		round_down((N - delta) * ncpu(A) / N) =3D
> +	 * 		round_down((N * ncpu(A) - delta * ncpu(A)) / N)	 >=3D
> +	 * 		round_down((N * ncpu(A) - delta * N) / N)	 =3D
> +	 * 		cpu(A) - delta
> +	 *
> +	 * 	then:
> +	 *
> +	 * 	vecs(A) - V >=3D ncpu(A) - delta - V
> +	 * 	=3D>
> +	 * 	V - vecs(A) <=3D V + delta - ncpu(A)
> +	 * 	=3D>
> +	 * 	vecs(B) <=3D N - ncpu(A)
> +	 * 	=3D>
> +	 * 	vecs(B) <=3D cpu(B)
> +	 *
> +	 * For nodes >=3D 3, it can be thought as one node and another big
> +	 * node given that is exactly what this algorithm is implemented,
> +	 * and we always re-calculate 'remaining_ncpus' & 'numvecs', and
> +	 * finally for each node X: vecs(X) <=3D ncpu(X).
> +	 *
> +	 */
> +	for (n =3D 0; n < nr_node_ids; n++) {
> +		unsigned nvectors, ncpus;
> +
> +		if (node_vectors[n].ncpus =3D=3D UINT_MAX)
> +			continue;
> +
> +		WARN_ON_ONCE(numvecs =3D=3D 0);
> +
> +		ncpus =3D node_vectors[n].ncpus;
> +		nvectors =3D max_t(unsigned, 1,
> +				 numvecs * ncpus / remaining_ncpus);
> +		WARN_ON_ONCE(nvectors > ncpus);
> +
> +		node_vectors[n].nvectors =3D nvectors;
> +
> +		remaining_ncpus -=3D ncpus;
> +		numvecs -=3D nvectors;
> +	}
> +}
> +
>  static int __irq_build_affinity_masks(unsigned int startvec,
>  				      unsigned int numvecs,
>  				      unsigned int firstvec,
> @@ -102,10 +252,11 @@ static int __irq_build_affinity_masks(unsigned int =
startvec,
>  				      struct cpumask *nmsk,
>  				      struct irq_affinity_desc *masks)
>  {
> -	unsigned int n, nodes, cpus_per_vec, extra_vecs, done =3D 0;
> +	unsigned int i, n, nodes, cpus_per_vec, extra_vecs, done =3D 0;
>  	unsigned int last_affv =3D firstvec + numvecs;
>  	unsigned int curvec =3D startvec;
>  	nodemask_t nodemsk =3D NODE_MASK_NONE;
> +	struct node_vectors *node_vectors;
> =20
>  	if (!cpumask_weight(cpu_mask))
>  		return 0;
> @@ -126,53 +277,57 @@ static int __irq_build_affinity_masks(unsigned int =
startvec,
>  		return numvecs;
>  	}
> =20
> -	for_each_node_mask(n, nodemsk) {
> -		unsigned int ncpus, v, vecs_to_assign, vecs_per_node;
> +	node_vectors =3D kcalloc(nr_node_ids,
> +			       sizeof(struct node_vectors),
> +			       GFP_KERNEL);
> +	if (!node_vectors)
> +		return -ENOMEM;
> +
> +	/* allocate vector number for each node */
> +	alloc_nodes_vectors(numvecs, node_to_cpumask, cpu_mask,
> +			    nodemsk, nmsk, node_vectors);
> +
> +	for (i =3D 0; i < nr_node_ids; i++) {
> +		unsigned int ncpus, v;
> +		struct node_vectors *nv =3D &node_vectors[i];
> +
> +		if (nv->nvectors =3D=3D UINT_MAX)
> +			continue;
> =20
>  		/* Get the cpus on this node which are in the mask */
> -		cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
> +		cpumask_and(nmsk, cpu_mask, node_to_cpumask[nv->id]);
>  		ncpus =3D cpumask_weight(nmsk);
>  		if (!ncpus)
>  			continue;
> =20
> -		/*
> -		 * Calculate the number of cpus per vector
> -		 *
> -		 * Spread the vectors evenly per node. If the requested
> -		 * vector number has been reached, simply allocate one
> -		 * vector for each remaining node so that all nodes can
> -		 * be covered
> -		 */
> -		if (numvecs > done)
> -			vecs_per_node =3D max_t(unsigned,
> -					(numvecs - done) / nodes, 1);
> -		else
> -			vecs_per_node =3D 1;
> -
> -		vecs_to_assign =3D min(vecs_per_node, ncpus);
> +		WARN_ON_ONCE(nv->nvectors > ncpus);
> =20
>  		/* Account for rounding errors */
> -		extra_vecs =3D ncpus - vecs_to_assign * (ncpus / vecs_to_assign);
> +		extra_vecs =3D ncpus - nv->nvectors * (ncpus / nv->nvectors);
> =20
> -		for (v =3D 0; curvec < last_affv && v < vecs_to_assign;
> -		     curvec++, v++) {
> -			cpus_per_vec =3D ncpus / vecs_to_assign;
> +		/* Spread allocated vectors on CPUs of the current node */
> +		for (v =3D 0; v < nv->nvectors; v++, curvec++) {
> +			cpus_per_vec =3D ncpus / nv->nvectors;
> =20
>  			/* Account for extra vectors to compensate rounding errors */
>  			if (extra_vecs) {
>  				cpus_per_vec++;
>  				--extra_vecs;
>  			}
> +
> +			/*
> +			 * wrapping has to be considered given 'startvec'
> +			 * may start anywhere
> +			 */
> +			if (curvec >=3D last_affv)
> +				curvec =3D firstvec;
>  			irq_spread_init_one(&masks[curvec].mask, nmsk,
>  						cpus_per_vec);
>  		}
> -
> -		done +=3D v;
> -		if (curvec >=3D last_affv)
> -			curvec =3D firstvec;
> -		--nodes;
> +		done +=3D nv->nvectors;
>  	}
> -	return done < numvecs ? done : numvecs;
> +	kfree(node_vectors);
> +	return done;
>  }
> =20
>  /*
> @@ -184,7 +339,7 @@ static int irq_build_affinity_masks(unsigned int star=
tvec, unsigned int numvecs,
>  				    unsigned int firstvec,
>  				    struct irq_affinity_desc *masks)
>  {
> -	unsigned int curvec =3D startvec, nr_present, nr_others;
> +	unsigned int curvec =3D startvec, nr_present =3D 0, nr_others =3D 0;
>  	cpumask_var_t *node_to_cpumask;
>  	cpumask_var_t nmsk, npresmsk;
>  	int ret =3D -ENOMEM;
> @@ -199,15 +354,17 @@ static int irq_build_affinity_masks(unsigned int st=
artvec, unsigned int numvecs,
>  	if (!node_to_cpumask)
>  		goto fail_npresmsk;
> =20
> -	ret =3D 0;
>  	/* Stabilize the cpumasks */
>  	get_online_cpus();
>  	build_node_to_cpumask(node_to_cpumask);
> =20
>  	/* Spread on present CPUs starting from affd->pre_vectors */
> -	nr_present =3D __irq_build_affinity_masks(curvec, numvecs,
> -						firstvec, node_to_cpumask,
> -						cpu_present_mask, nmsk, masks);
> +	ret =3D __irq_build_affinity_masks(curvec, numvecs, firstvec,
> +					 node_to_cpumask, cpu_present_mask,
> +					 nmsk, masks);
> +	if (ret < 0)
> +		goto fail_build_affinity;
> +	nr_present =3D ret;
> =20
>  	/*
>  	 * Spread on non present CPUs starting from the next vector to be
> @@ -220,12 +377,16 @@ static int irq_build_affinity_masks(unsigned int st=
artvec, unsigned int numvecs,
>  	else
>  		curvec =3D firstvec + nr_present;
>  	cpumask_andnot(npresmsk, cpu_possible_mask, cpu_present_mask);
> -	nr_others =3D __irq_build_affinity_masks(curvec, numvecs,
> -					       firstvec, node_to_cpumask,
> -					       npresmsk, nmsk, masks);
> +	ret =3D __irq_build_affinity_masks(curvec, numvecs, firstvec,
> +					 node_to_cpumask, npresmsk, nmsk,
> +					 masks);
> +	if (ret >=3D 0)
> +		nr_others =3D ret;
> +
> + fail_build_affinity:
>  	put_online_cpus();
> =20
> -	if (nr_present < numvecs)
> +	if (ret >=3D 0)
>  		WARN_ON(nr_present + nr_others < numvecs);
> =20
>  	free_node_to_cpumask(node_to_cpumask);
> @@ -235,7 +396,7 @@ static int irq_build_affinity_masks(unsigned int star=
tvec, unsigned int numvecs,
> =20
>   fail_nmsk:
>  	free_cpumask_var(nmsk);
> -	return ret;
> +	return ret < 0 ? ret : 0;
>  }
> =20
>  static void default_calc_sets(struct irq_affinity *affd, unsigned int af=
fvecs)

--=-GJXJ3F8mpTcIzs/xWm2w
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

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
PNauajAtxgRKfqfSMb+IcL/VXiPtVZOxVq+CTZeDJkaEmn/79vg8OYxpR+YhFF+tGlKf/Zc4id1P
AgMBAAGjggI3MIICMzAdBgNVHQ4EFgQU4oawcWXM1cPGdwGcIszDfjORVZAwHwYDVR0jBBgwFoAU
HmkqtNwo/kcYTiELP7ysES/wmPUwZQYDVR0fBF4wXDBaoFigVoZUaHR0cDovL3d3dy5pbnRlbC5j
b20vcmVwb3NpdG9yeS9DUkwvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWluZyUyMENB
JTIwNEEuY3JsMIGfBggrBgEFBQcBAQSBkjCBjzBpBggrBgEFBQcwAoZdaHR0cDovL3d3dy5pbnRl
bC5jb20vcmVwb3NpdG9yeS9jZXJ0aWZpY2F0ZXMvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIw
SXNzdWluZyUyMENBJTIwNEEuY3J0MCIGCCsGAQUFBzABhhZodHRwOi8vb2NzcC5pbnRlbC5jb20v
MAsGA1UdDwQEAwIHgDA8BgkrBgEEAYI3FQcELzAtBiUrBgEEAYI3FQiGw4x1hJnlUYP9gSiFjp9T
gpHACWeB3r05lfBDAgFkAgEJMB8GA1UdJQQYMBYGCCsGAQUFBwMEBgorBgEEAYI3CgMMMCkGCSsG
AQQBgjcVCgQcMBowCgYIKwYBBQUHAwQwDAYKKwYBBAGCNwoDDDBRBgNVHREESjBIoCoGCisGAQQB
gjcUAgOgHAwaam9uYXRoYW4uZGVycmlja0BpbnRlbC5jb22BGmpvbmF0aGFuLmRlcnJpY2tAaW50
ZWwuY29tMA0GCSqGSIb3DQEBBQUAA4IBAQBxGkHe05DNpYel4b9WbbyQqD1G6y6YA6C93TjKULZi
p8+gO1LL096ixD44+frVm3jtXMikoadRHQJmBJdzsCywNE1KgtrYF0k4zRWr7a28nyfGgQe4UHHD
7ARyZFeGd7AKSQ1y4/LU57I2Aw2HKx9/PXavv1JXjjO2/bqTfnZDJTQmOQ0nvlO3/gvbbABxZHqz
NtfHZsQWS7s+Elk2xGUQ0Po2pMCQoaPo9R96mm+84UP9q3OvSqMoaZwfzoUeAx2wGJYl0h3S+ABr
CPVfCgq9qnmVCn5DyHWE3V/BRjJCoILLBLxAxnmSdH4pF6wJ6pYRLEw9qoyNhpzGUIJU/Lk1MYIC
FzCCAhMCAQEwgZAweTELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAkNBMRQwEgYDVQQHEwtTYW50YSBD
bGFyYTEaMBgGA1UEChMRSW50ZWwgQ29ycG9yYXRpb24xKzApBgNVBAMTIkludGVsIEV4dGVybmFs
IEJhc2ljIElzc3VpbmcgQ0EgNEECEzMAAMamAkocC+WQNPgAAAAAxqYwCQYFKw4DAhoFAKBdMBgG
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MDgyMjE2MzY1NVowIwYJ
KoZIhvcNAQkEMRYEFJbVqQUVrZgLJFPSHE24A+Jl2SmdMA0GCSqGSIb3DQEBAQUABIIBAFmf07dg
9C+mdPXzvWxxJuqqgE7nCR0/tkj9eFdbGxCU+6K7gGMFxD0zQ7c/2Je5bfgiEfLkpZKz+o//NDNj
MHczZlgEEDjlnvIia+azAW1Ve9oOJDMjOvd8yOp8DErwAoejbFxxOopgNIipdD2X+E69e6+MKB/3
R8qni/eqFl6Ptue/3w/ly8p7rfgFc1KMRKORIWjWF+AuBAPVQCZkntSgMb++XkTSQwImZFIImdH2
YxNogGUQTDrx8GD9TJEUorzHWVuA9kQq73EyBN3jyAeL8VJZVgEnchCWRKom3Z05HZwe8UpNYIBr
oIahR4Wwk5WQtyYf2LFXddVy09kZFbAAAAAAAAA=


--=-GJXJ3F8mpTcIzs/xWm2w--
