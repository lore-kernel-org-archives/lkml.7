Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2771AC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C323B2073F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWVR4YKw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbfH2Idj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 04:33:39 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40364 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfH2Idg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:33:36 -0400
Received: by mail-pl1-f193.google.com with SMTP id h3so1236692pls.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 01:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jj42unEAJd8DuZLccSICE9pmQSDzRA7igGAWE7V6xkE=;
        b=IWVR4YKwiv5BjjG3DSj7SCE/8U9A6Q3OAu3bJx7n6xU8cFNIdeFc/WpXS8W4iSeCKI
         +nfaCapRIAQDpE8HWE7UZfl98FDFEHGLYRrKsLcn3VTSzOW2rKmzr0qGRllyFjSvulJ0
         RG4JqajzIJTYtyZJOUmjGg/tkVNEx/hdf8NUm07hLvYOgeZnvM5RW3HpqZ8kjV8c197W
         xtUr01g5Q3XO2rJNGgW9AITjf3kV43/iaaUJ3j/fcGhTwsmE1qeSm6bhrB9rMiTGV9UI
         FsBnxI3SU5YZJnHuvf9EdSb6Biu+W/nxjXQ6I6ssbR7i2Ui5cPMEQod2rXE3WMBHKfZe
         QrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jj42unEAJd8DuZLccSICE9pmQSDzRA7igGAWE7V6xkE=;
        b=T0LBYngr4ji12pH1Ix2C6TPkLQqZCRmYGpzeRhmYmDZEnqEbdRbOq9FibdEfZr4dZk
         egrRgTMzbbYym0YWHv0BmtKCQ328sDn91ZFKGfIgr5ujhXi6xP8l+J93iRB8XnaEjc74
         oVenu5tkiaVUWKKTEhK2DbxYeQiVZBD0wWzoqz+spOGrB0OFyvn/31Vj4ToezEBNtRbW
         FbcSOWUtGleZN0eqoM154am4ntOyHeT24aVNBppeztTVb8WNxrbMjB/EQSbnq0UnXqih
         CqfQfBrkx+3lXZ8/fZGI3feY7DxqNOq62dNO+JAiPf/tbwTOQb96sWXW2H1lZkSl7L/q
         m2nw==
X-Gm-Message-State: APjAAAXx9nUKYD59WH5AUCjSuwQTceGm/MQOPp4meyVbgG2HaDDTd7+o
        VxxB4k5iIYneAi1I0OI56zI=
X-Google-Smtp-Source: APXvYqyUNigojETLkLdzoRAJcLgW/XfFPRtJdg+gbAs3MotA3sck2XA+SnvycnWX3IG/8jr7xcQSEA==
X-Received: by 2002:a17:902:9a41:: with SMTP id x1mr8849394plv.88.1567067615042;
        Thu, 29 Aug 2019 01:33:35 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v22sm1260155pgk.69.2019.08.29.01.33.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 01:33:34 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v4 28/30] locking/lockdep: Support read-write lock's deadlock detection
Date:   Thu, 29 Aug 2019 16:31:30 +0800
Message-Id: <20190829083132.22394-29-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190829083132.22394-1-duyuyang@gmail.com>
References: <20190829083132.22394-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exclusive locks can be seen as a special use case of read-write locks: they
are read-write locks but only the exclusive write locks are present. To this
point, the read-write lock is a general form of locks that should be well
supported in lockdep, which, however, is not the reality. This patch series
designs and implements an algorithm to do this.

In the following sections, we first give an introduction to the locks in
Linux, then describe the problem statement, and after that we present the
design of the general read-write lock deadlock detection algorithm while in
the making we loosely prove that the algorithm indeed solves the deadlock
detection problem with a series of lemmas.

Read-write locks
----------------

It is necessary to take a close look at the read-write locks. Their design
subltety can be vastly impactful to deadlock checks. To this end, two
elements are singled out: recursive readers and the order to grant a lock to
readers and writers.

Recursive readers conceptually is very simple. If a task is allowed to
recursively acquire the same read locks, then it is recursive readers.  That
is it, no more and no less.

Lock grant order determines when there are contending readers and writers
simultaneously who gets the lock before the others.

Lets briefly review three read-write locks in Linux kernel. To be concise,
the following symbol R stands for read lock, W stands for write lock or
exclusive lock, RR stands for recursive lock, and X stands for any R, RR, or
W.

-----
rwsem
-----

The famous rwsem is not recursive. The lock prioritizes writers over
readers. A writer will block later readers to concurrently take the lock
with earlier readers. This grant order is necessary because otherwise, i.e.,
when readers own the lock, coming readers immediately would join them,
as a result writers would never be given a chance to ever take the lock in
cases like the above contrived extreme one.

Consequently, this case is not a deadlock scenario:

    T1        T2
    --        --

    R1        W2
    W2        R1

But this one is a deadlock scenario:

    T1        T2        T3
    --        --        --

    R1        W2
                        W1
    W2        R1

Since lockdep cannot differentiate them, it has to assume the worse-case
scenario.

------
rwlock
------

rwlock is recursive; readers are prioritized. Note that this simple order
has to be implemented because otherwise it is just too easy to have a
deadlock scenario:

    T1        T2
    --        --

    RR1
              W1
    RR1            [ Deadlock ]

Consequently, this case for rwlock is not a deadlock scenario:

    T1        T2        T3
    --        --        --

    RR1       W2
                        W1
    W2        RR1            [ No deadlock ]

-------
qrwlock
-------

qrwlock is a combination of rwsem and rwlock depending on the locking
contexts. It is recursive in interrupt context like rwlock, but not in
process context like rwsem, so a qrwlock lock class can be used as both
read lock and recursive-read lock [1]. Consequently, this case is a deadlock
scenario:

    T1        T2        T3
    --        --        --

    (In IRQ
     context)
    RR1       W2
                        W1
    W2        R1             [ Deadlock ]

and this is not a deadlock scenario:

    T1        T2        T3
    --        --        --

    (In IRQ
     context)
    W1        R2
                        W2
    RR2       W1            [ No deadlock ]

It is important to note that conceptually the two locking elements - locks
being recursive and lock grant order (e.g., a waiting writer can block later
readers) - are completely irrelevant to each other by nature. But because
whether a waiting writer can block later readers is so critical to deadlock
scenario determination, and because of the read-write locks Linux currently
has, we use the following terms to specifically refer to the read-write
locks in terms of these two locking elements:

  +----------------------+-----------+-------------------------+
  |                      | Recursive | Writer blocking readers |
  +----------------------+-----------+-------------------------+
  | Recursive-read locks |    Yes    |           No            |
  +----------------------+-----------+-------------------------+
  |      Read locks      |    No     |           Yes           |
  +----------------------+-----------+-------------------------+

Problem statement
-----------------

Waiting relations in a circular fashion are at the heart of a deadlock.
Because of the waiting circle, no one gets what it waits for and thus
they all wait forever. A circle is universally *necessary* for deadlocks,
but it is not *sufficient* with read-write locks. Deadlock circles can
be arbitrarily long with any number of tasks, each contributing some
arcs. But no matter how long the circle is, it has to complete with a
final arc, so the problem to solve deadlock detection is stated below as
a lemma:

Lemma #1
--------

  A deadlock can be and can only be the earliest detected at the *final*
  arc when it completes a waiting circle. In other words, at the final
  arc, the problem is try to find out whether this circle to come is a
  deadlock or not.

The following three facts are relevant to solving the problem:

 (a) With a new arc, determining whether it completes a circle is an
     easy task.

 (b) A new direct arc (direct dependency) can introduce a number of
     indirect arcs (indirect dependencies).

 (c) Checking all the additional arcs (direct and indirect) efficiently
     is not so easy since lock operations are frequent and lock graph
     can be gigantic. Actually, if it is free to check any number of
     arcs, deadlock detection even with read-write locks is fairly easy.

To solve the problem, performance is a real difficulty, so a good
algorithm should not only be self-evident that it does solve the problem
but also do so at low cost. We take a divide-and-conquer approach to the
solution: the entire problem is broken down into a comprehensive list of
simple and abstract problem cases to solve, and if each and every one of
them is solved, the entire problem is solved. These cases would be
labeled Case #x in the rest of this document.

Ready, here we go give it a try!

Solution
--------

Given a deadlock with a waiting circle, assume there are n tasks
contributing to that circle, denoted as T_1, T_2, ..., T_n. Depending on
n, there are two cases: (1) n = 1 and (2) n >= 2.

The first case corresponds to the recursion deadlock scenario, which can
be checked on the task held lock stack when attempting to acquire a
lock. Therefore, this (n = 1) case is skipped and we focus on the the
second one.

For other n tasks in deadlock, they can be grouped as (T_1, ..., T_n-1)
and T_n. And by virtually consolidating the former, we get a big imagined
T1 and T2 (with task numbers adjusted). This essentially means:

Lemma #2
--------

  Two tasks (T1 and T2) can virtually represent any situation with any
  number of tasks to check for deadlock.

We previously proposed the two-task model based on this. The two-task
model has the workload's locking behavior divided into two tasks:

 - T1: the entire previous locking behavior with the lock dependency
   graph to depict it.

 - T2: the current new locking behavior, i.e., the X1 -> X2 direct
   dependency.

It is worth noting that we also assume there can be multiple concurrent
instances of T1 to address the worst-case but most probable scenarios. Also
note that there is nuances regarding equivalency between T1 and the real
locking bahavior, so the following cases should be correctly handled:

Case #1.1:

    T1        T2
    --        --

    W1
    RR2       W3
    W3        W1   [Deadlock]

Case #1.2:

    T1        T2
    --        --

    W1
    RR2

    (W1 RR2 released
     in T1)

    RR2       W3
    W3        W1   [No deadlock]

Case #1.3:

    T1a       T1b       T2
    ---       ---       --

    W1        RR2       W3
    RR2       W3        W1   [No deadlock]

How long the actual circle is does not really matter and hence we have Lemma #3:

Lemma #3
--------

  Any deadlock scenario can be converted to an ABBA deadlock.

where AB comes from T1 and BA from T2 (T1 and T2 are made by Lemma #2),
which says any other associated locks in the graph are not critical or
necessary and thus may be ignored. For example:

    T1        T2
    --        --

    X1        X7
    X2        X2

    A         B
    X3        X3
    X4        X8
    B         A    [Deadlock]

    X5
    X6

from deadlock perspective is equivalent to an ABBA:

    T1        T2
    --        --

    A         B
    B         A    [Deadlock]

Based on Lemma #1, the problem as stated is what a difference the final
missing arc can make: deadlock or not, and based on Lemma #3, the goal
is to find an ABBA, we can then reason that the final arc is definitely
the BA or a critical part of the BA (based on Lemma #2) if a deadlock
scenario is about being created with this arc.

Now lets formalize an ABBA deadlock by defining the exclusiveness table
of locking acquiring operations for a read-write lock. Locking operations
being exclusive means that these two operations cannot be granted the lock
at the same time.

Table #1:

  +---------------------+---------------------+-----------+------------+
  |     X.A vs. X.B     | Recursive-read lock | Read lock | Write lock |
  +---------------------+---------------------+-----------+------------+
  | Recursive-read lock |         No          |    Yes    |     Yes    |
  +---------------------+---------------------+-----------+------------+
  |      Read lock      |         No          |    Yes    |     Yes    |
  +---------------------+---------------------+-----------+------------+
  |      Write lock     |         Yes         |    Yes    |     Yes    |
  +---------------------+---------------------+-----------+------------+

Note that this table has considered the read-lock can be blocked by
waiting write-lock problem. Also note that when using this table A is
above B, which means that for this case:

    T1        T2
    --        --

    X.A
              X.B

One should look for X.A vs. X.B in the table instead of the other way
around.

and for this one:

    T1        T2
    --        --

              X.A
    X.B

One should look for X.A vs. X.B as well in the table instead of the
other way around.

Depending on the read-write lock type of the final direct arc or
dependency in T2, there are nine contrived cases to solve:

 - read lock and read lock
 - read lock and recursive-read lock
 - read lock and write lock
 - write lock and read lock
 - write lock and recursive-read lock
 - write lock and write lock
 - recursive read lock and read lock
 - recursive read lock and recursive-read lock
 - recursive read lock and write lock

---------------------------------------------------------------
When the final dependency is ended with read lock and read lock
---------------------------------------------------------------

Case #2.1:

    T1        T2
    --        --

    X1        R2
    W2        R1   [Deadlock]

Case #2.2:

    T1        T2

    X1        R2
    R2        R1   [Deadlock]

Case #2.3:

    T1        T2

    X1        R2
    RR2       R1   [No deadlock]

--------------------------------------------------------------
When the final dependency is read lock and recursive-read lock
--------------------------------------------------------------

Case #3.1:

    T1        T2

    W1        R2
    X2        RR1   [Deadlock]

Case #3.2:

    T1        T2
    --        --

    R1        R2
    X2        RR1   [No deadlock]

Case #3.3:

    T1        T2

    RR1       R2
    X2        RR1   [No deadlock]

-----------------------------------------------------
When the final dependency is read lock and write lock
-----------------------------------------------------

Case #4.1:

    T1        T2
    --        --

    X1        R2
    R2        W1   [Deadlock]

Case #4.2:

    T1        T2
    --        --

    X1        R2
    W2        W1   [Deadlock]

Case #4.3:

    T1        T2
    --        --

    X1        R2
    RR2       W1   [No deadlock]

--------------------------------------------------------------
When the final dependency is recursive-read lock and read lock
--------------------------------------------------------------

Case #5.1:

    T1        T2
    --        --

    X1        RR2
    R2        R1   [Deadlock]

Case #5.2:

    T1        T2

    X1        RR2
    W2        R1   [Deadlock]

Case #5.3:

    T1        T2

    X1        RR2
    RR2       R1   [No deadlock]

------------------------------------------------------------------------
When the final dependency is recursive-read lock and recursive-read lock
------------------------------------------------------------------------

Case #6.1:

    T1        T2

    W1        RR2
    W2        RR1   [Deadlock]

Case #6.2:

    T1        T2

    W1        RR2
    R2        RR1   [Deadlock]

Case #6.3:

    T1        T2

    R1        RR2
    X2        RR1   [No deadlock]

Case #6.4:

    T1        T2

    RR1       RR2
    X2        RR1   [No deadlock]

Case #6.5:

    T1        T2
    --        --

    X1        RR2
    RR2       RR1   [No deadlock]

---------------------------------------------------------------
When the final dependency is recursive-read lock and write lock
---------------------------------------------------------------

Case #7.1:

    T1        T2

    X1        RR2
    W2        W1   [Deadlock]

Case #7.2:

    T1        T2

    X1        RR2
    R2        W1   [Deadlock]

Case #7.3:

    T1        T2

    X1        RR2
    RR2       W1   [No deadlock]

-----------------------------------------------------
When the final dependency is write lock and read lock
-----------------------------------------------------

Case #8.1:

    T1        T2

    X1        W2
    X2        R1   [Deadlock]

---------------------------------------------------------------
When the final dependency is write lock and recursive-read lock
---------------------------------------------------------------

Case #9.1:

    T1        T2

    W1        W2
    X2        RR1   [Deadlock]

Case #9.2:

    T1        T2

    R1        W2
    X2        RR1   [No deadlock]

Case #9.3:

    T1        T2

    RR1       W2
    X2        RR1   [No deadlock]

------------------------------------------------------
When the final dependency is write lock and write lock
------------------------------------------------------

Case #10:

    T1        T2
    --        --

    X1        W2
    X2        W1   [Deadlock]

Solving the above cases (no false positive or false negative) is
actually fairly easy to do; we therefore have our first *Simple
Algorithm*:

----------------
Simple Algorithm
----------------

Step 1
------

Keep track of each dependency's read or write ends. There is a
combination of nine types:

   - read -> read
   - read -> recursive read
   - read -> write
   - recursive read -> read
   - recursive read -> recursive read
   - recursive read -> write
   - write -> read
   - write -> recursive read
   - write -> write

Step 2
------

Redundancy check (as to whether adding a dependency into graph) for a
direct dependency needs to be beefed up considering dependency's read-
or write-ended types. We do redundancy check only for direct
dependencies.  A direct dependency is redundant to a direct dependency
only if their ends have the same types. If a dependency has different
read-write lock types from an existing dependency, then the existing one
will be be "upgraded": setting the end type towards more exclusive (the
exlusiveness increases from recursive read -> read -> write).

Step 3
------

Traverse the entire dependency graph (there may be more than one circle)
to find whether a circle can be formed by adding a new direct
dependency. A circle may or may not be a deadlock. The deciding rule is
simple: it is a deadlock if the new dependency to add have inversed
dependency with exclusive lock types in the graph for both A and B (the
ABBA deadlock scenario according to Lemma #3). Lock exclusiveness
relations are listed in Table #1.

Note that the 9 cases above according to the types of a direct
dependency can be modulated into two very simple cases to decide whether
it is a deadlock scenario of not.

    T1        T2
    --        --

    X1.A      X2.A
    X2.B      X1.B

 - If X1.A vs. X1.B are exclusive and X2.A vs. X2.B are exclusive then
   it is deadlock
 - Otherwise no deadlock

Note that the dependency graph is traversed until all dependency circles
are found and checked. This can avoid the following false negative case:

Case #11:

    T1        T2
    --        --

    RR1
    RR2

   (RR1 RR2 released)

    W1        RR2
    W2        RR1   [Deadlock]

*Simple Algorithm* done loosely described.

I wish we lived in a fairy-tale world that the problem has been solved
so easily, but the reality is not. Huge false negatives owing to
indirect dependencies, which is illustrated as the following case to
further solve:

Case #12:

    T1        T2
    --        --

    X1        X3
    RR2       RR2
    X3        X1   [Deadlock]

where X1's and X3's in the two tasks create a deadlock scenario (they
can be any one of the deadlock cases above). When checking the direct
dependency RR2 -> X1, there is no obvious deadlock using our *Simple
Algorithm*, however, under the hood the actual deadlock is formed after
RR2 introduces an indirect dependency X3 -> X1, which could comfortably
be missed.

To detect deadlock scenario like Case #12, a naive option is to check
all additional indirect dependencies, but this option would be so
inefficient and thus is simply passed. To find an efficient solution
instead, lets first contrive a no-deadlock Case #13 for comparison
(which is essentially rewritten from Case #5 or Case #7).

Case #13:

    T1        T2
    --        --

    X1
    X3        RR2
    RR2       X1   [No deadlock]

Having considered Case #12 and Case #13, a final working algorithm can
be formulated:

---------------
Final Algorithm
---------------

This *Final Algorithm* is beefed up from Simple Algorithm using the
following lemmas:

Lemma #4
--------

  The direct dependency RR2 -> X1 that serves in the path from X3 -> X1
  is *critical*.

Although the actual deadlock in Case #12 cannot be easily found by our
*Simple Algorithm*, however, by strengthening the algorithm somehow the
deadlock *definitely* can be found at adding the direct dependency
(i.e., RR2 -> X1 in Case #7), see Lemma #1. In other words, a *critical*
direct dependency (i.e., the final arc) suffices to find any deadlock if
there is a deadlock, otherwise there is no deadlock. As a matter of
fact, after a false deadlock (RR2 -> X1 -> RR2), if the search continues
the true deadlock (RR2 -> X1 -> RR2 -> X3 -> RR2) will eventually be
taken out of the hood.

Lemma #5
--------

  Missed in Case #13, the game changer to Case #12 is that it has X3 in
  T2 whereas Case #13 does not.

Having considered this, our *Final Algorithm* can be adjusted from the
*Simple Algorithm* by adding:

(a). Continue searching the graph to find a new circle.

(b). In the new circle, if previous locks in T2's stack (or chain) are in
     it and then check whether the circle is indeed a deadlock. This is
     done by checking each newly introduced indirect dependency (such as
     X3 -> X1 in Case #12) according to our Simple Algorithm as before.

(c). If a deadlock is found then the algorithm is done, otherwise go to
     (a) unless the entire graph is traversed.

Why does Lemma #5 work?

Lemma #6
--------

  Lemma #5 nicely raises a question whether a previous lock involved
  indirect dependency in T2 is *necessary*. The answer is yes, otherwise
  our *Simple Algorithm* has already solved the problem.

Lemma #5 and Lemma #6 extend our two-task model which divides the workload's
locking behavior into two virtual tasks:

 - T1: the entire previous locking behavior with the lock dependency
   graph to depict it.

 - T2: the current task's held lock stack (or lock chain) worth of
   direct and indirect dependencies (previously T2 is just an additional
   new direct dependency).

Lemma #7
--------

  It is also natural to ask whether indirect dependencies with a
  starting lock in T2 only is *sufficient*: what if the indirect
  dependency has a starting lock from T1. The answer is yes too.

Because Lemma #2 and Lemma #3 say that any deadlock is an ABBA so that
T1 can only contribute an AB and T2 must have a BA, and the final direct
dependency is the BA or the ending part of the BA in T2.

Finally, since we assumed T1 has no deadlock and Lemma #4 says the new
dependency is *critical*, then any deadlock formed by the new direct or
indirect dependencies introduced in T2 (which is the BA part) will
definitely be found with *Simple Algorithm* or *Final Algorithm*
respectively.

This is perhaps the most subtle and difficult part of this algorithm. To
test Lemma #12 holds true, one may try to contrive a case based on Case #13
or freely to generate a deadlock case if possible.

Anyway, we welcome any new cases. Cases matter in this algorithm because
as stated before, this algorithm solves the read-write lock deadlock
detection problem by having solved all the contrived cases (be it deadlock
or no deadlock). And if anyone comes up with a new case that is not covered
here, it likely will defeat this algorithm, but if otherwise this algorithm
just works sound and complete.

*Final Algorithm* done loosely described.

Now that the bulk of the implementation of the read-write lock deadlock
detection algorithm is done, the lockdep internal performance statistics can
be collected:

(The workload used as usual is: make clean; reboot; make vmlinux -j8.)

Before this series
------------------

 direct dependencies:                  9284 [max: 32768]
 indirect dependencies:               41804
 all direct dependencies:            215468
 dependency chains:                   12109 [max: 65536]
 dependency chain hlocks:             45588 [max: 327680]
 in-hardirq chains:                      87
 in-softirq chains:                     398
 in-process chains:                   10757
 stack-trace entries:                125652 [max: 524288]
 combined max dependencies:       377734896
 max bfs queue depth:                   253
 chain lookup misses:                 13218
 chain lookup hits:              7016143232
 cyclic checks:                       11906
 redundant checks:                        0
 redundant links:                         0
 find-mask forwards checks:            2082
 find-mask backwards checks:           5481

After this series
-----------------

 direct dependencies:                  4579 [max: 32768]
 indirect dependencies:               39614
 all direct dependencies:            211089
 dependency chains:                   12893 [max: 65536]
 dependency chain hlocks:             47623 [max: 327680]
 in-hardirq chains:                      87
 in-softirq chains:                     401
 in-process chains:                   11083
 stack-trace entries:                127520 [max: 524288]
 combined max dependencies:       392107584
 max bfs queue depth:                   230
 chain lookup misses:                 14258
 chain lookup hits:               909929196
 cyclic checks:                        5178
 redundant links:                      5988
 find-mask forwards checks:             526
 find-mask backwards checks:           5128

Noticeably, we have slightly more chains and chain lookup misses, but none
of them raises concerns. More noticeably, we have half as many direct
dependencies due to the consolidation of forward and backward lock_lists.
And thanks to the added cached trylock chains and skipping checks if the
dependency is redundant, the chain lookup hits are significantly more, the
cyclic checks are halved, and the find-mask forwards checks are only as many
as a quarter, which can be translated into better performance after this
patch series.

Reference:
[1]: Recursive read deadlocks and Where to find them by Boqun Feng at
Linux Plumbers Conference 2018.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 227 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 178 insertions(+), 49 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 5c97dbf..f1c083c 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -86,6 +86,7 @@
  */
 static arch_spinlock_t lockdep_lock = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
 static struct task_struct *lockdep_selftest_task_struct;
+static bool inside_selftest(void);
 
 static int graph_lock(void)
 {
@@ -2040,38 +2041,159 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
 }
 
 /*
- * Prove that the dependency graph starting at <src> can not
- * lead to <target>. If it can, there is a circle when adding
- * <target> -> <src> dependency.
+ * Prove that when adding <target> -> <src> dependency into the dependency
+ * graph, there is no deadlock. This is done by:
+ *
+ * 1. Determine whether the graph starting at <src> can lead to <target>.
+ *    If it can, there is a circle.
+ *
+ * 2. If there is a circle, there may or may not be a deadlock, which is
+ *    then comprehensively checked according to the general read-write
+ *    lock deadlock detection algorithm.
  *
  * Print an error and return 0 if it does.
  */
 static noinline int
-check_deadlock_graph(struct held_lock *src, struct held_lock *target,
-		     struct lock_trace **const trace)
+check_deadlock_graph(struct task_struct *curr, struct held_lock *src,
+		     struct held_lock *target, struct lock_trace **const trace)
 {
-	int ret;
+	int ret, i;
+	bool init = true;
 	struct lock_list *uninitialized_var(target_entry);
 	struct lock_list src_entry = {
 		.class[1] = hlock_class(src),
 		.parent = NULL,
 	};
 
+	if (DEBUG_LOCKS_WARN_ON(hlock_class(src) == hlock_class(target)))
+		return 0;
+
 	debug_atomic_inc(nr_cyclic_checks);
 
-	ret = check_path(hlock_class(target), &src_entry, &target_entry, true);
+	while (true) {
+		ret = check_path(hlock_class(target), &src_entry,
+				 &target_entry, init);
+		init = false;
+
+		/* Found a circle, is it deadlock? */
+		if (unlikely(!ret)) {
+			struct lock_list *parent;
 
-	if (unlikely(!ret)) {
-		if (!*trace) {
 			/*
-			 * If save_trace fails here, the printing might
-			 * trigger a WARN but because of the !nr_entries it
-			 * should not do bad things.
+			 * Check this direct dependency.
+			 *
+			 * Step 1: next's lock type and source dependency's
+			 * lock type are exclusive, no?
+			 *
+			 * Find the first dependency after source dependency.
 			 */
-			*trace = save_trace();
-		}
+			parent = find_next_dep_in_path(&src_entry, target_entry);
+			if (!parent) {
+				DEBUG_LOCKS_WARN_ON(1);
+				return -3;
+			}
+
+			if (!lock_excl_table[get_lock_type1(parent)]
+					    [hlock_type(src)])
+				goto cont;
+
+			/*
+			 * Step 2: prev's lock type and target dependency's
+			 * lock type are exclusive, yes?
+			 */
+			if (lock_excl_table[hlock_type(target)]
+					   [get_lock_type2(target_entry)])
+				goto print;
 
-		print_circular_bug(&src_entry, target_entry, src, target);
+			/*
+			 * Check indirect dependency from even further
+			 * previous lock.
+			 */
+			for (i = 0; i < curr->lockdep_depth; i++) {
+				struct held_lock *prev = curr->held_locks + i;
+
+				if (prev->irq_context != src->irq_context)
+					continue;
+
+				/*
+				 * We arrived at the same prev lock in this
+				 * direct dependency checking.
+				 */
+				if (prev == target)
+					break;
+
+				/*
+				 * This previous lock has the same class as
+				 * the src (the next lock to acquire); this
+				 * must be a recursive read case. Skip.
+				 */
+				if (hlock_class(prev) == hlock_class(src))
+					continue;
+
+				/*
+				 * Since the src lock (the next lock to
+				 * acquire) is not nested lock, so up to
+				 * now this prev class cannot be the src
+				 * class, then does the path have this
+				 * previous lock?
+				 *
+				 * With read locks it would be possible a
+				 * lock can reoccur in a path. For example:
+				 *
+				 * -> RL1 -> RL2 -> RL3 -> RL1 -> ...
+				 *
+				 * and for another three examples:
+				 *
+				 * Ex1: -> RL1 -> WL2 -> RL3 -> RL1
+				 * Ex2: -> WL1 -> RL2 -> RL3 -> WL1
+				 * Ex3: -> RL1 -> RL2 -> RL3 -> WL1
+				 *
+				 * This can result in that a path may
+				 * encounter a lock twice or more, but we
+				 * used the breadth-first search algorithm
+				 * that will find the shortest path,
+				 * which means that this path can not have
+				 * the same (middle) lock multiple times.
+				 * However, is Ex3 a problem?
+				 */
+				parent = find_lock_in_path(hlock_class(prev),
+							   target_entry);
+				if (parent) {
+					/*
+					 * Yes, we have a candidate indirect
+					 * dependency to check.
+					 *
+					 * Again step 2: new prev's lock
+					 * type and its dependency in graph
+					 * are exclusive, yes?
+					 *
+					 * Note that we don't need step 1
+					 * again.
+					 */
+					if (lock_excl_table[hlock_type(prev)]
+							   [get_lock_type2(parent)])
+						goto print;
+				}
+			}
+cont:
+			mark_lock_unaccessed(target_entry);
+			continue;
+print:
+			if (!*trace) {
+				/*
+				 * If save_trace fails here, the printing
+				 * might trigger a WARN but because of the
+				 * !nr_entries it should not do bad things.
+				 */
+				save_trace();
+			}
+
+			print_circular_bug(&src_entry, target_entry,
+					   src, target);
+			break;
+		} else
+			/* The graph is all traversed or an error occurred */
+			break;
 	}
 
 	return ret;
@@ -2687,7 +2809,7 @@ static inline void inc_chains(void)
 	       struct lock_trace **const trace, struct lock_chain *chain)
 {
 	struct lock_list *entry;
-	int ret;
+	int ret, upgraded = 0;
 
 	if (!hlock_class(prev)->key || !hlock_class(next)->key) {
 		/*
@@ -2708,6 +2830,17 @@ static inline void inc_chains(void)
 	}
 
 	/*
+	 * Filter out the direct dependency with the same lock class, which
+	 * is legitimate only if the next lock is the recursive-read type,
+	 * otherwise we should not have been here in the first place.
+	 */
+	if (hlock_class(prev) == hlock_class(next)) {
+		WARN_ON_ONCE(next->read != LOCK_TYPE_RECURSIVE);
+		WARN_ON_ONCE(prev->read == LOCK_TYPE_WRITE);
+		return 2;
+	}
+
+	/*
 	 * Is the <prev> -> <next> dependency already present?
 	 *
 	 * (this may occur even though this is a new chain: consider
@@ -2719,24 +2852,31 @@ static inline void inc_chains(void)
 		if (fw_dep_class(entry) == hlock_class(next)) {
 			debug_atomic_inc(nr_redundant);
 
-			list_add_tail_rcu(&chain->chain_entry, &entry->chains);
-			__set_bit(chain - lock_chains, lock_chains_in_dep);
-
 			/*
 			 * For a direct dependency, smaller type value
 			 * generally means more lock exlusiveness; we
 			 * keep the more exlusive one, in other words,
 			 * we "upgrade" the dependency if we can.
 			 */
-			if (prev->read < get_lock_type1(entry))
+			if (prev->read < get_lock_type1(entry)) {
 				set_lock_type1(entry, prev->read);
-			if (next->read < get_lock_type2(entry))
+				upgraded = 1;
+			}
+			if (next->read < get_lock_type2(entry)) {
 				set_lock_type2(entry, next->read);
+				upgraded = 1;
+			}
 
 			if (distance == 1)
 				entry->distance = 1;
 
-			return 1;
+			if (!upgraded) {
+				list_add_tail_rcu(&chain->chain_entry,
+						  &entry->chains);
+				__set_bit(chain - lock_chains,
+					  lock_chains_in_dep);
+				return 1;
+			}
 		}
 	}
 
@@ -2750,24 +2890,13 @@ static inline void inc_chains(void)
 	 * MAX_CIRCULAR_QUEUE_SIZE) which keeps track of a breadth of nodes
 	 * in the graph whose neighbours are to be checked.
 	 */
-	ret = check_deadlock_graph(next, prev, trace);
+	ret = check_deadlock_graph(curr, next, prev, trace);
 	if (unlikely(ret <= 0))
 		return 0;
 
 	if (!check_irq_usage(curr, prev, next))
 		return 0;
 
-	/*
-	 * For recursive read-locks we do all the dependency checks,
-	 * but we dont store read-triggered dependencies (only
-	 * write-triggered dependencies). This ensures that only the
-	 * write-side dependencies matter, and that if for example a
-	 * write-lock never takes any other locks, then the reads are
-	 * equivalent to a NOP.
-	 */
-	if (next->read == LOCK_TYPE_RECURSIVE || prev->read == LOCK_TYPE_RECURSIVE)
-		return 1;
-
 	if (!*trace) {
 		*trace = save_trace();
 		if (!*trace)
@@ -3160,20 +3289,15 @@ static int validate_chain(struct task_struct *curr, struct held_lock *next,
 
 		/*
 		 * Add dependency only if this lock is not the head of the
-		 * chain, and if it's not a second recursive-read lock. If
-		 * not, there is no need to check further.
+		 * chain, and if it's not a nest lock, otherwise there is no
+		 * need to check further.
 		 */
-		if (!(chain->depth > 1 && ret != LOCK_TYPE_RECURSIVE &&
-		      ret != LOCK_TYPE_NEST))
+		if (!(chain->depth > 1 && ret != LOCK_TYPE_NEST))
 			goto out_unlock;
 	}
 
-	/*
-	 * Only non-recursive-read entries get new dependencies
-	 * added:
-	 */
 	if (chain) {
-		if (hlock->read != LOCK_TYPE_RECURSIVE && hlock->check) {
+		if (hlock->check) {
 			int distance = curr->lockdep_depth - depth + 1;
 
 			if (!check_prev_add(curr, hlock, next, distance,
@@ -5015,7 +5139,7 @@ static void remove_class_from_lock_chain(struct pending_free *pf,
 #ifdef CONFIG_PROVE_LOCKING
 	struct lock_chain *new_chain;
 	u64 chain_key;
-	int i;
+	int i, found = 0;
 
 	for (i = chain->base; i < chain->base + chain->depth; i++) {
 		if (chain_hlocks[i] != class - lock_classes)
@@ -5030,21 +5154,26 @@ static void remove_class_from_lock_chain(struct pending_free *pf,
 				sizeof(chain_hlocks_type[0]));
 		}
 		/*
-		 * Each lock class occurs at most once in a lock chain so once
-		 * we found a match we can break out of this loop.
+		 * Recursive-read lock class may occurs more than once in a
+		 * lock chain.
 		 */
-		goto recalc;
+		found = 1;
 	}
 	/* Since the chain has not been modified, return. */
-	return;
+	if (!found)
+		return;
 
-recalc:
 	chain_key = INITIAL_CHAIN_KEY;
 	for (i = chain->base; i < chain->base + chain->depth; i++)
 		chain_key = iterate_chain_key(chain_key, chain_hlocks[i],
 					      chain_hlocks_type[i]);
+	/*
+	 * It would be weird that the new key remains the same, but can't
+	 * say impossible.
+	 */
 	if (chain->depth && chain->chain_key == chain_key)
 		return;
+
 	/* Overwrite the chain key for concurrent RCU readers. */
 	WRITE_ONCE(chain->chain_key, chain_key);
 	/*
-- 
1.8.3.1

